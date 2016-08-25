require "rails_helper"

describe "觀察者更改email", type: :request do
  context "成功送出" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }
    before { signin_court_observer(court_observer) }

    context "新的 email 為別人正在驗證中的 email ，也可以成功送出" do
      let!(:court_observer_with_unconfirmed_email) { create :court_observer_without_validate, unconfirmed_email: "5566@gmail.com" }
      subject { put "/observer/email", court_observer: { email: court_observer_with_unconfirmed_email.unconfirmed_email, current_password: "123123123" } }

      it "成功送出" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end
    end

    context "發送信件" do
      subject { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "123123123" } }
      before { signin_court_observer(court_observer) }

      it "成功發送" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end
    end

    context "內容連結點擊後成功換置新的 email" do
      before { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "123123123" } }
      subject! { get "/observer/confirmation", confirmation_token: court_observer.reload.confirmation_token }

      it "成功更新email" do
        expect(court_observer.reload.email).to eq("windwizard@gmail.com")
      end
    end

    context "跳轉至登入頁，用新的 email 登入" do
      before { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "123123123" } }
      before { signout_court_observer }
      before { get "/observer/confirmation", confirmation_token: court_observer.reload.confirmation_token }
      subject { post "/observer/sign_in", court_observer: { email: "windwizard@gmail.com", password: "123123123" } }

      it "導向觀察者登入" do
        expect(response).to redirect_to("/observer/sign_in")
      end

      it "新email 登入成功" do
        expect { subject }.to change { court_observer.reload.current_sign_in_at }
      end
    end

    context "已登入時  驗證email" do
      before { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "123123123" } }
      subject { get "/observer/confirmation", confirmation_token: court_observer.reload.confirmation_token }

      it "導向個人評鑑頁面" do
        expect(subject).to redirect_to("/observer")
      end
    end
  end

  context "失敗送出" do
    let!(:court_observer) { create :court_observer, name: "丁丁觀察者", email: "dingding@gmail.com" }

    context "內容錯誤" do
      context "新email空白" do
        before { signin_court_observer(court_observer) }
        subject! { put "/observer/email", court_observer: { email: "", current_password: "123123123" } }

        it "顯示錯誤提示" do
          expect(response.body).to match("email 的格式是無效的")
        end
      end

      context "新email格式不符" do
        before { signin_court_observer(court_observer) }
        subject! { put "/observer/email", court_observer: { email: "windwizard", current_password: "123123123" } }

        it "顯示錯誤提示" do
          expect(response.body).to match("是無效的")
        end
      end

      context "密碼驗證錯誤" do
        before { signin_court_observer(court_observer) }
        subject! { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "wrongpassword" } }

        it "顯示錯誤提示" do
          expect(response.body).to match("是無效的")
        end
      end

      context "密碼驗證空白" do
        before { signin_court_observer(court_observer) }
        subject! { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "" } }

        it "顯示錯誤提示" do
          expect(response.body).to match("不能是空白字元")
        end
      end
    end

    context "email 已被使用" do
      before { signin_court_observer(court_observer) }
      let!(:court_observer2) { create :court_observer, email: "windwizard@gmail.com" }
      subject! { put "/observer/email", court_observer: { email: "windwizard@gmail.com", current_password: "123123123" } }

      context "新 email 是別人的 email" do
        subject! { put "/observer/email", court_observer: { email: court_observer2.email, current_password: "123123123" } }

        it "提示已經被使用" do
          expect(response.body).to match("email 已經被使用")
        end
      end

      context "新 email 跟原本的一樣" do
        subject! { put "/observer/email", court_observer: { email: court_observer.email, current_password: "123123123" } }

        it "提示不可與原本相同" do
          expect(response.body).to match("email 不可與原本相同")
        end
      end
    end

    context "其他情境" do
      context "觀察者A與B 有相同的待驗證email, A點完驗證連結之後 B才點驗證連結" do
        let!(:court_observer_A) { observer_with_unconfirm_email("ggyy@gmail.com") }
        let!(:court_observer_B) { observer_with_unconfirm_email("ggyy@gmail.com") }
        before { get "/observer/confirmation", confirmation_token: court_observer_A.reload.confirmation_token }
        subject! { get "/observer/confirmation", confirmation_token: court_observer_B.confirmation_token }

        it "觀察者A 的email 置換成功" do
          expect(court_observer_A.reload.email).to eq("ggyy@gmail.com")
        end

        it "觀察者B 的email 置換失敗" do
          expect { subject }.not_to change { court_observer_B.email }
        end
      end
    end
  end
end
