require "rails_helper"
feature "觀察者透過 email 建立帳號到通過認證", type: :feature do
  let!(:observer_a) { { name: "當事人a", email: "test@gmail.com", password: "00000000" } }

  # Todo fix sign_up without capybara

  feature "成功註冊後，送出驗證信" do
    Given "前往觀察者註冊頁" do
      before { visit(new_court_observer_registration_path) }
      When "填寫註冊資訊並送出表單" do
        before { capybara_input_sign_up_observer(observer_a) }
        before { capybara_regiter_submit_observer }

        Then "觀察者收到註冊認證信" do
          expect(page).to have_content("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")
        end
      end
    end
  end

  feature "帳號必須經過驗證後才能登入" do
    Scenario "尚未通過驗證" do
      Given "觀察者A已註冊，但尚未通過驗證" do
        before { visit(new_court_observer_registration_path) }
        before { capybara_input_sign_up_observer(observer_a) }
        before { capybara_regiter_submit_observer }

        When "以觀察者A的帳號進行登入" do
          before { visit(new_court_observer_session_path) }
          before { capybara_input_sign_in_observer(observer_a) }
          before { capybara_sign_in_observer }

          Then "登入失敗" do
            expect(page).to have_content("您的帳號需需要經過驗證後，才能繼續。")
          end
        end
      end
    end

    # Todo fix sign_up without capybara
  end
end
