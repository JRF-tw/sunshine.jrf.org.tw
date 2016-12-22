module Capybara
  module AdminHelper
    def admin_signin_user(user = nil)
      visit(new_user_session_path)
      user ||= create(:admin_user)
      within('#new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
      end
      click_button '登入'
    end

    def admin_search_lawyer(filter = {})
      visit(admin_lawyers_path)
      within('#admin\/lawyer_search') do
        fill_in 'q_name_cont', with: filter[:name]
        fill_in 'q_current_cont', with: filter[:current]
        fill_in 'q_email_cont', with: filter[:email]
        select(filter[:status], from: 'q_confirmed_at_not_null')
      end
      click_button '搜尋'
    end

    def admin_lawyer_input_create(name, email)
      within('#new_admin_lawyer') do
        fill_in 'admin_lawyer_name', with: name
        fill_in 'admin_lawyer_email', with: email
      end
    end
  end
end
