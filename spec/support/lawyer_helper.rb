module LawyerHelper

  def signin_lawyer(lawyer = nil)
    lawyer ||= create(:lawyer, :with_password, :with_confirmed)
    post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: lawyer.password }
    @current_lawyer = lawyer if response.status == 302
  end

  def signout_lawyer
    delete "/lawyer/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/lawyer/profile"
    @current_lawyer = nil
  end

  def current_lawyer
    @current_lawyer
  end

  def lawyer_with_unconfirm_email(email)
    @lawyer = create(:lawyer, :with_password, :with_confirmed)
    signin_lawyer(@lawyer)
    put "/lawyer/email", lawyer: { email: email, current_password: @lawyer.password }
    signout_lawyer
    @lawyer
  end

  def lawyer_subscribe_story_date_today
    lawyer = create(:lawyer, :with_confirmed, :with_password)
    story = create(:story, :with_schedule_date_today)
    Lawyer::StorySubscriptionCreateContext.new(story).perform(lawyer)
    lawyer
  end

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
    @current_lawyer
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
