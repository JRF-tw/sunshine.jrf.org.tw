module PartyHelper

  def signin_party(party = nil)
    party ||= create(:party)
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

  def party_with_unconfirm_email(email)
    @party = create(:party)
    signin_party(@party)
    put "/party/email", party: { email: email, current_password: @party.password }
    signout_party
    @party
  end

  def party_with_unconfirm_phone_number(phone_number)
    party = create(:party)
    signin_party(party)
    post "/party/phone", party: { phone_number: phone_number }
    signout_party
    party
  end

  def party_with_sms_send_count(counts)
    party = create(:party)
    party.sms_sent_count.value = counts
    party
  end

  def party_generate_phone_varify_code(party, code = nil)
    party.phone_varify_code.value = code ? code.to_s : rand(1000..9999).to_s
    party.save
  end

  def party_chang_phone_number_times(times)
    times.times { put "/party/phone", party: { phone_number: "09" + rand(10_000_000..99_999_999).to_s } }
  end

  def party_verifing_error_times(times)
    times.times { put "/party/phone/verifing", party: { phone_varify_code: "" } }
  end

  def party_subscribe_story_date_today
    party = create(:party, :already_confirmed)
    story = create(:story, :with_schedule_date_today)
    Party::StorySubscriptionToggleContext.new(story).perform(party)
    party
  end

end
