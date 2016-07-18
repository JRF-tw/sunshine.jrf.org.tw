module ObserverHelper

  def signin_court_observer(court_observer = nil)
    court_observer ||= FactoryGirl.create(:court_observer)
    post "/observer/sign_in", court_observer: { email: court_observer.email, password: court_observer.password }
    @current_court_observer = court_observer if response.status == 302
  end

  def signout_court_observer
    delete "/observer/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/observer/profile"
    @current_court_observer = nil
  end

  def current_court_observer
    @current_court_observer
  end

  def observer_with_unconfirm_email_init(email)
    @observer = FactoryGirl.create(:court_observer)
    signin_court_observer(@observer)
    put "/observer/email", court_observer: { email: email, current_password: @observer.password }
    signout_court_observer
    @observer
  end

end
