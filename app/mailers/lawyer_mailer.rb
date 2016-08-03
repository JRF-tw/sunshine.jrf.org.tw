class LawyerMailer < ApplicationMailer
  def story_before_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    mail(to: @lawyer.email, subject: "開庭通知")
  end

  def story_after_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    mail(to: @lawyer.email, subject: "評鑑通知")
  end
end
