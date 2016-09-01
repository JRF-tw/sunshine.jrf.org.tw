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
      perform_sidekiq_job(fetch_sidekiq_last_job)
      open_email(email)
      current_email.find("a").click
    end

    def capybara_sign_in_observer
      click_button "登入"
      save_page
    end
  end
end
