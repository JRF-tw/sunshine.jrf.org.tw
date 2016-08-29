class PartyMailer < ApplicationMailer
  def story_before_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    @subject = @story.detail_info + "開庭通知"
    @date = @story.schedules.last.start_at
    @courtroom = @story.schedules.last.courtroom
    mail(to: @party.email, subject: @subject)
  end

  def story_after_judge_notice(story_id, party_id)
    @story = Story.find(story_id)
    @party = Party.find(party_id)
    @subject = @story.detail_info + "開庭完畢，邀請您提供您的寶貴意見！"
    mail(to: @party.email, subject: @subject)
  end
end
