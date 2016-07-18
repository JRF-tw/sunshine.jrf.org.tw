module PartyHelper

  def signin_party(party = nil)
    party ||= FactoryGirl.create(:party)
    post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password }
    @current_party = party if response.status == 302
  end

  def signout_party
    delete "/party/sign_out", {}, "HTTP_REFERER" => "http://www.example.com/party/profile"
    @current_party = nil
  end

  def current_party
    @current_party
  end

  def init_party_with_unconfirm_email(email)
    @party = FactoryGirl.create(:party)
    signin_party(@party)
    put "/party/email", party: { email: email, current_password: @party.password }
    signout_party
    @party
  end

  def init_party_with_unconfirm_phone_number(phone_number)
    party = FactoryGirl.create(:party)
    signin_party(party)
    post "/party/phone", party: { phone_number: phone_number }
    signout_party
    party
  end

  def init_party_with_sms_send_count(counts)
    party = FactoryGirl.create(:party)
    party.sms_sent_count.value = counts
    party
  end

  def generate_phone_varify_code_for_party(party, code = nil)
    party.phone_varify_code.value = code ? code.to_s : rand(1000..9999).to_s
    party.save
  end

end
