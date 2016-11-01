class PartyMailer < ApplicationMailer
  def story_before_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    @token = Digest::MD5.hexdigest(@party.email+'P2NVel3pHp')
    @remind_story_before_judge = MailerPresenters.new.remind_story_before_judge(@story)
    @google_calendar_link = MailerPresenters.new.google_calendar_link(@story)
    @subject = @story.detail_info + '開庭通知'
    mail(to: @party.email, subject: @subject)
  end

  def story_after_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    @token = Digest::MD5.hexdigest(@party.email+'P2NVel3pHp')
    @remind_story_after_judge = MailerPresenters.new.remind_story_after_judge(@story)
    @subject = @story.detail_info + '開庭完畢，邀請您提供您的寶貴意見！'
    mail(to: @party.email, subject: @subject)
  end
end
