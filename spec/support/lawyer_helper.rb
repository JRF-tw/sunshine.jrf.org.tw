module LawyerHelper

  def signin_lawyer(lawyer = nil)
    lawyer ||= FactoryGirl.create(:lawyer, :with_password, :with_confirmed)
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
    @lawyer = FactoryGirl.create(:lawyer, :with_password, :with_confirmed)
    signin_lawyer(@lawyer)
    put "/lawyer/email", lawyer: { email: email, current_password: @lawyer.password }
    signout_lawyer
    @lawyer
  end

end
