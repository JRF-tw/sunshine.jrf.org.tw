require "rails_helper"

describe "密碼設定頁", type: :request do
  context "成功載入頁面" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password, name: "火焰律師", email: "firelawyer@gmail.com" }
    let(:token) { lawyer.send_reset_password_instructions }
    subject { get "/lawyer/password/edit", reset_password_token: token }

    context "有登入" do
      before { signin_lawyer(lawyer) }
      before { subject }

      it "應顯示該律師的email和姓名" do
        expect(response.body).to match("火焰律師")
        expect(response.body).to match("firelawyer@gmail.com")
      end
    end

    context "沒登入" do
      before { subject }

      it "應顯示該律師的email和姓名" do
        expect(response.body).to match("火焰律師")
        expect(response.body).to match("firelawyer@gmail.com")
      end
    end
  end

  context "失敗載入頁面" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password, name: "火焰律師", email: "firelawyer@gmail.com" }
    let(:token) { lawyer.send_reset_password_instructions }
    
    context "條件" do
      context "token 不正確" do
        subject! { get "/lawyer/password/edit", reset_password_token: "invalid token" }
        it "顯示token 錯誤" do
          expect(flash[:error]).to eq("無效的驗證連結")
        end
      end

      context "token 正確 但登入者非本人" do
        before { signin_lawyer }
        subject! { get "/lawyer/password/edit", reset_password_token: token }

        it "顯示使用者錯誤" do
          expect(flash[:error]).to eq("你僅能修改本人的帳號")
        end
      end
    end

    context "有登入時載入失敗" do
      before { signin_lawyer }
      subject! { get "/lawyer/password/edit", reset_password_token: token }

      it "轉跳至個人資料編輯頁" do
        expect(response).to redirect_to("/lawyer/profile")
      end
    end

    context "沒登入時載入失敗" do
      subject! { get "/lawyer/password/edit", reset_password_token: "fart" }

      it "轉跳至個人資料編輯頁" do
        expect(response).to redirect_to("/lawyer/sign_in")
      end
    end
  end

end
