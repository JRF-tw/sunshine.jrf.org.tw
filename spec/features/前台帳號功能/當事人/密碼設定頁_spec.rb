require "rails_helper"

describe "當事人密碼設定頁", type: :request do
  context "密碼設定頁" do
    context "成功載入頁面" do
      let!(:party) { create :party }
      let(:token) { party.send_reset_password_instructions }

      context "有登入" do
        before { signin_party(party) }
        subject! { get "/party/password/edit", reset_password_token: token }

        it "應顯示該當事人的姓名和ID" do
          expect(response.body).to match(party.name)
          expect(response.body).to match(party.identify_number)
        end
      end

      context "沒登入" do
        subject! { get "/party/password/edit", reset_password_token: token }

        it "應顯示該當事人的姓名和ID" do
          expect(response.body).to match(party.name)
          expect(response.body).to match(party.identify_number)
        end
      end
    end

    context "失敗載入頁面" do
      let!(:party) { create :party }
      let(:token) { party.send_reset_password_instructions }

      context "條件" do
        context "token 不正確" do
          subject! { get "/party/password/edit", reset_password_token: "wrong token" }

          it "顯示 token 錯誤" do
            expect(flash[:error]).to eq("無效的驗證連結")
          end
        end

        context "token 正確 但登入者非本人" do
          before { signin_party }
          subject! { get "/party/password/edit", reset_password_token: token }

          it "顯示使用者錯誤" do
            expect(flash[:error]).to eq("你僅能修改本人的帳號")
          end
        end
      end

      context "有登入時，轉跳至個人資料編輯頁" do
        before { signin_party }
        subject! { get "/party/password/edit", reset_password_token: token }

        it "轉跳至個人資料編輯頁" do
          expect(response).to redirect_to("/party/profile")
        end
      end

      context "沒登入時，轉跳至登入頁" do
        subject! { get "/party/password/edit", reset_password_token: "wrong token" }

        it "轉跳至當事人登入頁" do
          expect(response).to redirect_to("/party/sign_in")
        end
      end
    end

    context "成功設定" do
      let!(:party) { create :party }
      let(:token) { party.send_reset_password_instructions }
      subject { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

      it "沒登入時自動登入" do
        expect { subject }.to change { party.reload.current_sign_in_at }
      end

      it "有登入時，成功更改密碼" do
        expect { subject }.to change { party.reload.encrypted_password }
      end

      context "若手機尚未驗證，則會自動轉跳到手機驗證頁" do
        let!(:party_without_phone_unmber) { create :party, phone_number: nil }
        let(:token) { party_without_phone_unmber.send_reset_password_instructions }
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

        it "轉跳到手機驗證頁" do
          follow_redirect!
          expect(response).to redirect_to("/party/phone/new")
        end
      end

      context "若手機已驗證，則會轉跳到評鑑記錄頁" do
        let!(:party) { create :party }
        let(:token) { party.send_reset_password_instructions }
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

        it "轉跳評鑑紀錄頁" do
          expect(response).to redirect_to("/party")
        end
      end
    end

    context "失敗設定" do
      let!(:party) { create :party }
      let(:token) { party.send_reset_password_instructions }

      context "密碼空白" do
        subject! { put "/party/password", party: { password: "", password_confirmation: "", reset_password_token: token } }

        it "顯示不可為空" do
          expect(response.body).to match("不能是空白字元")
        end
      end

      context "密碼長度過短" do
        subject! { put "/party/password", party: { password: "11", password_confirmation: "11", reset_password_token: token } }

        it "顯示密碼過短" do
          expect(response.body).to match("過短（最短是 8 個字）")
        end
      end

      context "密碼兩次不一致" do
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "33333333", reset_password_token: token } }

        it "顯示不可為空" do
          expect(response.body).to match("兩次輸入須一致")
        end
      end
    end
  end
end
