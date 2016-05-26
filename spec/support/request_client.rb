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

  def current_user
    @current_user
  end

  def current_bystander
    @current_bystander
  end

<<<<<<< 3507ae72642a8cd25ed71f020213120060a7453d
  def current_defendant
    @current_defendant
=======
  def find_reset_password_token_by_Bystander
    @reset_password_token, enc = Devise.token_generator.generate(Bystander, :reset_password_token)
    bystander.reset_password_token   = enc
    bystander.reset_password_sent_at = Time.now.utc
    bystander.save(validate: false)
>>>>>>> rspec
  end
end
