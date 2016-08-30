module Capybara
  module LawyerHelper
    def capybara_register_lawyer(lawyer_data = nil)
      lawyer_data ||= { name: "孔令則", phone: 33_381_841, email: "kungls@hotmail.com" }
      lawyer = Import::CreateLawyerContext.new(lawyer_data).perform
      lawyer
    end

    def capybara_setting_password_lawyer(lawyer, password:)
      lawyer.update_attributes(password: password)
      lawyer.confirm
    end

    def capybara_signin_lawyer(lawyer, password:)
      visit(new_lawyer_session_path)
      within("#new_lawyer") do
        fill_in "lawyer_email", with: lawyer.email
        fill_in "lawyer_password", with: password
      end
      click_button "登入"
      lawyer
    end

    def capybara_submit_password_lawyer(password:)
      within("#new_lawyer") do
        fill_in "lawyer_password", with: password
        fill_in "lawyer_password_confirmation", with: password
      end
      click_button "送出"
    end

    def capybara_sign_out_lawyer
      click_link "登出"
    end
  end
end
