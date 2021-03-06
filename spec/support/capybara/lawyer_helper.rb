module Capybara
  module LawyerHelper
    def build_lawyer(lawyer_data = nil)
      lawyer_data ||= { name: '孔令則', phone: 33_381_841, email: 'kungls@hotmail.com' }
      lawyer = Import::CreateLawyerContext.new(lawyer_data).perform
      lawyer
    end

    def setting_password_lawyer(lawyer, password:)
      lawyer.update_attributes(password: password)
      lawyer.confirm
    end

    def signin_lawyer(email:, password: '123123123')
      visit(new_lawyer_session_path)
      within('#new_lawyer') do
        fill_in 'lawyer_email', with: email
        fill_in 'lawyer_password', with: password
      end
      click_button '登入'
    end

    def sign_out_lawyer
      find(:xpath, "//a[@href='/lawyer/sign_out']").click
    end

    def lawyer_run_schedule_score_flow(schedule, judge = Judge.last)
      visit(input_info_lawyer_score_schedules_path)
      lawyer_input_info_schedule_score(schedule.story)
      lawyer_input_date_schedule_score(schedule)
      lawyer_input_judge_schedule_score(judge)
      lawyer_create_schedule_score
    end

    def lawyer_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'schedule_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'schedule_score_story_type'
      within('#new_schedule_score') do
        fill_in 'schedule_score_year', with: year ? year : story.year
        fill_in 'schedule_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'schedule_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def lawyer_input_date_schedule_score(schedule)
      within('#new_schedule_score') do
        fill_in 'schedule_score_start_on', with: schedule.start_on
      end
      click_button '下一步'
    end

    def lawyer_input_judge_schedule_score(judge)
      within('#new_schedule_score') do
        fill_in 'schedule_score_judge_name', with: judge.name
      end
      click_button '下一步'
    end

    def lawyer_create_schedule_score
      3.times.each_with_index { |i| choose("schedule_score_score_1_#{i + 1}_20") }
      5.times.each_with_index { |i| choose("schedule_score_score_2_#{i + 1}_20") }
      within('#new_schedule_score') do
        fill_in 'schedule_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def lawyer_edit_schedule_score
      visit(lawyer_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def lawyer_run_verdict_score_flow(story)
      visit(input_info_lawyer_score_verdicts_path)
      lawyer_input_info_verdict_score(story)
      lawyer_create_verdict_score
    end

    def lawyer_input_info_verdict_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'verdict_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'verdict_score_story_type'
      within('#new_verdict_score') do
        fill_in 'verdict_score_year', with: year ? year : story.year
        fill_in 'verdict_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'verdict_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def lawyer_create_verdict_score
      choose('verdict_score_score_3_1_20')
      6.times.each_with_index { |i| first("label[for$='verdict_score_score_3_2_#{i + 1}_100']").click }
      within('#new_verdict_score') do
        fill_in 'verdict_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def lawyer_edit_verdict_score
      visit(lawyer_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def lawyer_input_set_password_form(password: nil, password_confirmation: nil)
      within('#new_lawyer') do
        fill_in 'lawyer_password', with: password
        fill_in 'lawyer_password_confirmation', with: password_confirmation || password
      end
    end

    def lawyer_input_registration_form(name, email)
      within('#new_lawyer') do
        fill_in 'lawyer_name', with: name
        fill_in 'lawyer_email', with: email
        check('policy_agreement')
      end
    end

    def lawyer_input_edit_email_form(email, password)
      within('#edit_lawyer') do
        fill_in 'lawyer_email', with: email
        fill_in 'lawyer_current_password', with: password
      end
    end
  end
end
