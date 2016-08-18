module Capybara
  module ObserverHelper
    def capybara_input_sign_up_observer(observer_data)
      within("#new_court_observer") do
        fill_in "court_observer_name", with: observer_data[:name]
        fill_in "court_observer_email", with: observer_data[:email]
        fill_in "court_observer_password", with: observer_data[:password]
        fill_in "court_observer_password_confirmation", with: observer_data[:password]
      end
      check("policy_agreement")
      save_page
    end

    def capybara_input_sign_in_observer(observer_data)
      within("#new_court_observer") do
        fill_in "court_observer_email", with: observer_data[:email]
        fill_in "court_observer_password", with: observer_data[:password]
      end
      save_page
    end

    def capybara_regiter_submit_observer
      click_button "註冊"
      save_page
    end

    def capybara_confirm_observer(email)
      observer = CourtObserver.find_by(email: email)
      visit(court_observer_confirmation_path(confirmation_token: observer.confirmation_token))
      save_page
    end

    def capybara_sign_in_observer
      click_button "登入"
      save_page
    end

    def capybara_sign_out_observer
      click_link "登出"
      save_page
    end

    def scr
      save_and_open_screenshot
    end
  end
end

