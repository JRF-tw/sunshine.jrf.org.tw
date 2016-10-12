require "rails_helper"

describe "律師更改email", type: :request do
  context "成功送出" do
    let!(:lawyer) { create :lawyer, :with_confirmed, :with_password, :with_confirmation_token }
    before { signin_lawyer(lawyer) }

    context "新的 email 為別人正在驗證中的 email ，也可以成功送出" do
      let!(:lawyer_with_unconfirmed_email) { create :lawyer, unconfirmed_email: "556677@gmail.com" }
      subject { put "/lawyer/email", lawyer: { email: lawyer_with_unconfirmed_email.unconfirmed_email, current_password: "123123123" } }

      it "成功送出" do
        expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :resend_confirmation_instructions)
      end
    end

    context "發送信件" do
      subject { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }
      before { signin_lawyer(lawyer) }

      it "成功發送" do
        expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :resend_confirmation_instructions)
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
    let!(:lawyer) { create :lawyer, :with_confirmed, :with_password }

    context "內容錯誤" do
      context "新email空白" do
        before { signin_lawyer(lawyer) }
        subject! { put "/lawyer/email", lawyer: { email: "", current_password: "123123123" } }

        it "顯示錯誤提示" do
          expect(response.body).to match("email 的格式是無效的")
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
      let!(:lawyer2) { create :lawyer, :with_confirmed, :with_password, email: "windwizard@gmail.com" }
      subject! { put "/lawyer/email", lawyer: { email: "windwizard@gmail.com", current_password: "123123123" } }

      context "新 email 是別人的 email" do
        subject! { put "/lawyer/email", lawyer: { email: lawyer2.email, current_password: "123123123" } }

        it "提示已經被使用" do
          expect(response.body).to match("email 已被使用")
        end
      end

      context "新 email 跟原本的一樣" do
        subject! { put "/lawyer/email", lawyer: { email: lawyer.email, current_password: "123123123" } }

        it "提示不可與原本相同" do
          expect(response.body).to match("email 不可與原本相同")
        end
      end
    end

    context "其他情境" do
      context "律師A與B 有相同的待驗證email, A點完驗證連結之後 B才點驗證連結" do
        let!(:lawyer_A) { lawyer_with_unconfirm_email("ggyy@gmail.com") }
        let!(:lawyer_B) { lawyer_with_unconfirm_email("ggyy@gmail.com") }
        before { get "/lawyer/confirmation", confirmation_token: lawyer_A.reload.confirmation_token }
        subject { get "/lawyer/confirmation", confirmation_token: lawyer_B.confirmation_token }

        it "律師A 的email 置換成功" do
          expect(lawyer_A.reload.email).to eq("ggyy@gmail.com")
        end

        it "律師B 的email 置換失敗" do
          expect { subject }.not_to change { lawyer_B.email }
        end
      end
    end
  end
end
