require "rails_helper"

describe "觀察者密碼設定頁", type: :request do
  context "成功載入頁面" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }
    let(:token) { court_observer.send_reset_password_instructions }

    context "有登入" do
      before { signin_court_observer(court_observer) }
      subject! { get "/observer/password/edit", reset_password_token: token }

      it "應顯示該觀察者的email和姓名" do
        expect(response.body).to match("丁丁觀察者")
        expect(response.body).to match("dingding@gmail.com")
      end
    end

    context "沒登入" do
      subject! { get "/observer/password/edit", reset_password_token: token }

      it "應顯示該觀察者的email和姓名" do
        expect(response.body).to match("丁丁觀察者")
        expect(response.body).to match("dingding@gmail.com")
      end
    end
  end

  context "失敗載入頁面" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }
    let(:token) { court_observer.send_reset_password_instructions }

    context "條件" do
      context "token 不正確" do
        subject! { get "/observer/password/edit", reset_password_token: "invalid token" }
        it "顯示token 錯誤" do
          expect(flash[:error]).to eq("無效的驗證連結")
        end
      end

      context "token 正確 但登入者非本人" do
        before { signin_court_observer }
        subject! { get "/observer/password/edit", reset_password_token: token }

        it "顯示使用者錯誤" do
          expect(flash[:error]).to eq("你僅能修改本人的帳號")
        end
      end
    end

    context "有登入時載入失敗" do
      before { signin_court_observer }
      subject! { get "/observer/password/edit", reset_password_token: token }

      it "轉跳至個人資料編輯頁" do
        expect(response).to redirect_to("/observer/profile")
      end
    end

    context "沒登入時載入失敗" do
      subject! { get "/observer/password/edit", reset_password_token: "fart" }

      it "轉跳至觀察者登入頁" do
        expect(response).to redirect_to("/observer/sign_in")
      end
    end
  end

  context "成功設定" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }
    let(:token) { court_observer.send_reset_password_instructions }
    subject { put "/observer/password", court_observer: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

    it "沒登入時，則自動登入" do
      expect { subject }.to change { court_observer.reload.current_sign_in_at }
    end

    it "有登入時，密碼亦修改成功" do
      expect { subject }.to change { court_observer.reload.encrypted_password }
    end

    it "轉跳到觀察者的評鑑記錄頁" do
      expect(subject).to redirect_to("/observer")
    end
  end

  context "失敗設定" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }
    let(:token) { court_observer.send_reset_password_instructions }

    context "密碼空白" do
      subject! { put "/observer/password", court_observer: { password: "", password_confirmation: "", reset_password_token: token } }

      it "提示輸入密碼" do
        expect(response.body).to match("不能是空白字元")
      end
    end

    context "密碼長度過短" do
      subject! { put "/observer/password", court_observer: { password: "11", password_confirmation: "11", reset_password_token: token } }

      it "提示密碼長度過短" do
        expect(response.body).to match("過短（最短是 8 個字）")
      end
    end

    context "密碼兩次不一致" do
      subject! { put "/observer/password", court_observer: { password: "11111111", password_confirmation: "22222222", reset_password_token: token } }

      it "提示密碼兩次須一致" do
        expect(response.body).to match("兩次輸入須一致")
      end
    end
  end
end
