module RequestClient
  def signout_user
    delete "/users/sign_out"
    @current_user = nil
  end

  def signin_user(user = nil)
    user ||= FactoryGirl.create(:admin_user)
    data = 
    post "/users/sign_in", user: { email: user.email, password: user.password }
    @current_user = user if response.status == 302
  end

  def current_user
    @current_user
  end
end