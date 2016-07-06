module RequestClient
  def signout_user
    delete "/users/sign_out"
    @current_user = nil
  end

  def signout_court_observer
    delete "/observer/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/observer/profile"
    @current_court_observer = nil
  end

  def signout_party
    delete "/party/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/party/profile"
    @current_party = nil
  end

  def signout_lawyer
    delete "/lawyer/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/lawyer/profile"
    @current_lawyer = nil
  end

  def signin_user(user = nil)
    user ||= FactoryGirl.create(:admin_user)
    post "/users/sign_in", user: { email: user.email, password: user.password }
    @current_user = user if response.status == 302
  end

  def signin_court_observer(court_observer = nil)
    court_observer ||= FactoryGirl.create(:court_observer)
    post "/observer/sign_in", court_observer: { email: court_observer.email, password: court_observer.password }
    @current_court_observer = court_observer if response.status == 302
  end

  def signin_party(party = nil)
    party ||= FactoryGirl.create(:party)
    post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password }
    @current_party = party if response.status == 302
  end

  def signin_lawyer(lawyer = nil)
    lawyer ||= FactoryGirl.create(:lawyer, :with_password, :with_confirmed)
    post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: lawyer.password }
    @current_lawyer = lawyer if response.status == 302
  end

  def current_user
    @current_user
  end

  def current_court_observer
    @current_court_observer
  end

  def current_party
    @current_party
  end

  def current_lawyer
    @current_lawyer
  end

end
