class PartyMailer < ApplicationMailer
  def story_before_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    mail(to: @party.email, subject: "開庭通知")
  end

  def story_after_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    mail(to: @party.email, subject: "評鑑通知")
  end
end
