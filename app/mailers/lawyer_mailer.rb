class LawyerMailer < ApplicationMailer
  def story_before_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    @court_wording = @story.court_wording + "開庭通知"
    @date = @story.schedules.last.date
    mail(to: @lawyer.email, subject: @court_wording)
  end

  def story_after_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    @court_wording = @story.court_wording + "開庭完畢，邀請您提供您的寶貴意見！"
    mail(to: @lawyer.email, subject: @court_wording)
  end
end
