require "rails_helper"
feature "觀察者透過 email 建立帳號到通過認證", type: :feature, js: true do
  let!(:observer_a) { { name: "當事人a", email: "test@gmail.com", password: "00000000" } }

  feature "相同的 email 無法再註冊" do
    Given "已存在觀察者A" do
      before { visit(new_court_observer_registration_path) }
      before { capybara_input_sign_up_observer(observer_a) }
      before { capybara_regiter_submit_observer }
      before { capybara_confirm_observer(observer_a[:email]) }
      before { manual_http_request(:delete, "/observer/sign_out") }

      When "使用觀察者A的 email 進行註冊" do
        let!(:observer_b) { { name: "當事人b", email: observer_a[:email], password: "199999999" } }
        before { visit(new_court_observer_registration_path) }
        before { capybara_input_sign_up_observer(observer_b) }
        before { capybara_regiter_submit_observer }

        Then "帳號建立失敗" do
          expect(page).to have_content("您已經註冊請直接登入")
        end
      end
    end
  end

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
          before { capybara_log_in_observer }

          Then "登入失敗" do
            expect(page).to have_content("您的帳號需需要經過驗證後，才能繼續。")
          end
        end
      end
    end

    Scenario "已通過驗證" do
      Given "觀察者A已註冊，且點擊（前往）過認證信內的連結" do
        before { visit(new_court_observer_registration_path) }
        before { capybara_input_sign_up_observer(observer_a) }
        before { capybara_regiter_submit_observer }
        before { capybara_confirm_observer(observer_a[:email]) }
        before { manual_http_request(:delete, "/observer/sign_out") }

        When "以觀察者A的帳號進行登入" do
          before { visit(new_court_observer_session_path) }
          before { capybara_input_sign_in_observer(observer_a) }
          before { capybara_log_in_observer }

          Then "登入成功" do
            expect(page).to have_content("成功登入了。")
          end
        end
      end
    end
  end
end
