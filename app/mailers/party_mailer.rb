class PartyMailer < ApplicationMailer
  def open_court_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    mail(to: @party.email,
      subject: '開庭通知')
  end

  def close_court_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    mail(to: @party.email,
      subject: '評鑑通知')
  end
end
