module RequestClient
  def signout_user
    delete "/users/sign_out"
    @current_user = nil
  end

  def signout_bystander
    delete "/bystanders/sign_out", {}, {'HTTP_REFERER' => 'http://www.example.com/bystanders'}
    @current_bystander = nil
  end

  def signin_user(user = nil)
    user ||= FactoryGirl.create(:admin_user)
    data =
    post "/users/sign_in", user: { email: user.email, password: user.password }
    @current_user = user if response.status == 302
  end

  def signin_bystander(bystander = nil)
    bystander ||= FactoryGirl.create(:bystander)
    date =
    post "/bystanders/sign_in", bystander: { email: bystander.email, password: "123123123" }
    @current_bystander = bystander if response.status == 302
  end

  def signin_defendant(defendant = nil)
    defendant ||= FactoryGirl.create(:defendant)
    data =
    post "/defendants/sign_in", defendant: { identify_number: defendant.identify_number, password: defendant.password }
    @current_defendant = defendant if response.status == 302
  end

  def signin_lawyer(lawyer = nil)
    lawyer ||= FactoryGirl.create(:lawyer, :with_password_and_confirmed)
    data =
    post "/lawyers/sign_in", lawyer: { email: lawyer.email, password: lawyer.password }
    @current_lawyer = lawyer if response.status == 302
  end

  def current_user
    @current_user
  end

  def current_bystander
    @current_bystander
  end

  def current_defendant
    @current_defendant
  end

end
