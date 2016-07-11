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
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password }
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

      it "轉跳至律師登入頁" do
        expect(response).to redirect_to("/lawyer/sign_in")
      end
    end
  end

  context "失敗設定" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password }
    let(:token) { lawyer.send_reset_password_instructions }

    context "密碼空白" do
      subject! { put "/lawyer/password", lawyer: { password: "", password_confirmation: "", reset_password_token: token } }

      it "提示輸入密碼" do
        expect(response.body).to match("不能是空白字元")
      end
    end

    context "密碼長度過短" do
      subject! { put "/lawyer/password", lawyer: { password: "11", password_confirmation: "11", reset_password_token: token } }

      it "提示密碼長度過短" do
        expect(response.body).to match("過短（最短是 8 個字）")
      end
    end

    context "密碼兩次不一致" do
      subject! { put "/lawyer/password", lawyer: { password: "11111111", password_confirmation: "22222222", reset_password_token: token } }

      it "提示密碼兩次須一致" do
        expect(response.body).to match("兩次輸入須一致")
      end

    end
  end

  context "成功設定" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password }
    let(:token) { lawyer.send_reset_password_instructions }
    subject { put "/lawyer/password", lawyer: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

    it "註冊狀態若原本為未註冊，則設定後會改為已註冊" do
      expect { subject }.to change { lawyer.reload.confirmed? }
    end

    it "沒登入時，則自動登入" do
      expect { subject }.to change { lawyer.reload.current_sign_in_at }
    end

    it "有登入時，密碼亦修改成功" do
      expect { subject }.to change { lawyer.reload.encrypted_password }
    end

    it "轉跳到律師的評鑑記錄頁" do
      expect(subject).to redirect_to("/lawyer")
    end
  end

  context "忘記密碼" do
    context "成功送出" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password, email: "firewizard@gmail.com" }
      let!(:params) { { email: "firewizard@gmail.com" } }
      subject { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }

      it "發送重設密碼信" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end
    end

    context "失敗送出" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password, email: "firewizard@gmail.com" }

      context "email 空白" do
        subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }
        let!(:params) { { email: "" } }

        it "顯示查無此律師帳號" do
          follow_redirect!
          expect(response.body).to match("無此律師帳號")
        end
      end

      context "email 格式不符" do
        subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }
        let!(:params) { { email: "firewizar" } }

        it "顯示查無此律師帳號" do
          follow_redirect!
          expect(response.body).to match("無此律師帳號")
        end
      end

      context "email 不存在" do
        subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }
        let!(:params) { { email: "icewizard@gmail.com" } }

        it "顯示查無此律師帳號" do
          follow_redirect!
          expect(response.body).to match("無此律師帳號")
        end
      end

      context "該帳號存在，但是尚未完成註冊" do
        let!(:lawyer_unconfirmed) { FactoryGirl.create :lawyer, :with_password, email: "windwizard@gmail.com" }
        subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }
        let!(:params) { { email: "windwizard@gmail.com" } }

        it "顯示查無此律師帳號" do
          follow_redirect!
          expect(response.body).to match("該帳號尚未註冊")
        end
      end
    end

    context "重設密碼頁" do
      it "(和註冊的密碼設定同一頁，所以不用再重複測試)" do
      end
    end
  end

  context "更改 email" do
    context "成功送出" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password }
      before { signin_lawyer(lawyer) }

      context "新的 email 為別人正在驗證中的 email ，也可以成功送出" do
        let!(:lawyer_unconfirmed) { FactoryGirl.create :lawyer, :with_password, email: "windwizard@gmail.com" }
        subject { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }

        it "" do
          pending "詢問後補上"
          raise
        end
      end

      context "發送信件" do
        subject { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }
        before { signin_lawyer(lawyer) }

        it "成功發送" do
          expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
        end
      end

      context "內容連結點擊後成功換置新的 email" do
        before { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }
        subject! { get "/lawyer/confirmation", confirmation_token: lawyer.reload.confirmation_token }

        it "成功更新email" do
          expect(lawyer.reload.email).to eq("windwizard@gmail.com")
        end
      end

      context "跳轉至登入頁，用新的 email 登入" do
        before { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }
        before { signout_lawyer }
        before { get "/lawyer/confirmation", confirmation_token: lawyer.reload.confirmation_token }
        subject { post "/lawyer/sign_in", lawyer: { email: "windwizard@gmail.com", password: "123123123" } }

        it "導向律師登入" do
          expect(response).to redirect_to("/lawyer/sign_in")
        end

        it "新email 登入成功" do
          expect { subject }.to change { lawyer.reload.current_sign_in_at }
        end
      end
    end

    context "失敗送出" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_confirmed, :with_password }

      context "內容錯誤" do
        context "新email空白" do
          before { signin_lawyer(lawyer) }
          subject! { put "/lawyer/email", lawyer: { email: "", current_password: "123123123" } }

          it "顯示錯誤提示" do
            expect(response.body).to match("不能是空白字元")
          end
        end

        context "新email格式不符" do
          before { signin_lawyer(lawyer) }
          subject! { put "/lawyer/email", lawyer: { email: "windwizard", current_password: "123123123" } }

          it "顯示錯誤提示" do
            expect(response.body).to match("是無效的")
          end
        end

        context "密碼驗證錯誤" do
          before { signin_lawyer(lawyer) }
          subject! { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "wrongpassword" } }

          it "顯示錯誤提示" do
            expect(response.body).to match("是無效的")
          end
        end

        context "密碼驗證空白" do
          before { signin_lawyer(lawyer) }
          subject! { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "" } }

          it "顯示錯誤提示" do
            expect(response.body).to match("不能是空白字元")
          end
        end
      end

      context "email 已被使用" do
        before { signin_lawyer(lawyer) }
        let!(:lawyer2) { FactoryGirl.create :lawyer, :with_confirmed, :with_password, email: "windwizard@gmail.com" }
        subject! { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }

        context "新 email 是別人的 email" do
          subject! { put "/lawyer/email", lawyer: { email: lawyer2.email, current_password: "123123123" } }

          it "提示已經被使用" do
            expect(response.body).to match("已經被使用")
          end
        end

        context "新 email 跟原本的一樣" do
          subject! { put "/lawyer/email", lawyer: { email: lawyer.email, current_password: "123123123" } }

          it "提示不可與原本相同" do
            expect(response.body).to match("不可與原本相同")
          end
        end
      end

      context "其他情境" do
        before { signin_lawyer(lawyer) }
        subject! { put "/lawyer/email", lawyer: { email: "", current_password: "123123123" } }

        it "" do
          pending "詢問後補上"
          raise
        end
      end
    end
  end

end
