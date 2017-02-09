class LawyerMailer < ApplicationMailer
  def story_before_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    @token = @lawyer.unsubscribe_token
    @open_court_info_wording = MailerPresenters.new.remind_story_before_judge(@story)
    @google_calendar_link = MailerPresenters.new.google_calendar_link(@story)
    @subject = @story.detail_info + '開庭通知'
    mail(to: @lawyer.email, subject: @subject)
  end

  def story_after_judge_notice(story_id, lawyer_id)
    @story = Story.find(story_id)
    @lawyer = Lawyer.find(lawyer_id)
    @token = @lawyer.unsubscribe_token
    @score_schedules_link = generate_score_schedules_link
    @close_court_info_wording = MailerPresenters.new.remind_story_after_judge(@story)
    @subject = @story.detail_info + '開庭完畢，邀請您提供您的寶貴意見！'
    mail(to: @lawyer.email, subject: @subject)
  end

  def after_verdict_notice(verdict_id, lawyer_id)
    verdict = Verdict.find(verdict_id)
    @story = verdict.story
    @lawyer = Lawyer.find(lawyer_id)
    @court = @story.court
    @verdict_url = verdict.file.url
    @limit_date = @story.adjudge_date + 3.months
    @score_verdicts_link = generate_score_verdicts_link
    @subject = @story.detail_info + '案件判決書已公開上網，邀請您提供您的寶貴意見！'
    mail(to: @lawyer.email, subject: @subject)
  end

  def active_verdict_notice(verdict_id, lawyer_id)
    verdict = Verdict.find(verdict_id)
    @story = verdict.story
    @lawyer = Lawyer.find(lawyer_id)
    @court = @story.court
    @verdict_url = verdict.file.url
    @limit_date = @story.adjudge_date + 3.months
    @score_verdicts_link = generate_score_verdicts_link
    @subject = @story.detail_info + '判決書已經上網，邀請您給予寶貴的意見！'
    mail(to: @lawyer.email, subject: @subject)
  end

  private

  def generate_score_schedules_link
    input_judge_lawyer_score_schedules_url(
      schedule_score: {
        court_id: @story.court,
        year: @story.year,
        word_type: @story.word_type,
        number: @story.number,
        story_type: @story.story_type,
        start_on: @story.schedules.last.start_on
      }
    )
  end

  def generate_score_verdicts_link
    new_lawyer_score_verdict_url(
      verdict_score: {
        court_id: @story.court,
        year: @story.year,
        word_type: @story.word_type,
        number: @story.number,
        story_type: @story.story_type
      }
    )
  end
end
