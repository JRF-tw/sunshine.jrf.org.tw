module Capybara
  module PartyHelper
    def party_input_name_and_id(name, identify_number)
      within('#new_party') do
        fill_in 'party_name', with: name
        fill_in 'party_identify_number', with: identify_number
      end
      check('policy_agreement')
    end

    def party_input_password(password, password_confirmation = nil)
      within('#new_party') do
        fill_in 'party_password', with: password
        fill_in 'party_password_confirmation', with: password_confirmation || password
      end
    end

    def party_input_phone_number(phone_number)
      within('.edit_party') do
        fill_in 'party_unconfirmed_phone', with: phone_number
      end
    end

    def party_input_verify_code(verify_code)
      within('.edit_party') do
        fill_in 'party_phone_varify_code', with: verify_code
      end
    end

    def party_input_edit_email(email:, password: '12321313213')
      within('#edit_party') do
        fill_in 'party_email', with: email
        fill_in 'party_current_password', with: password
      end
    end

    def signin_party(identify_number:, password: '12321313213')
      visit(new_party_session_path)
      within('#new_party') do
        fill_in 'party_identify_number', with: identify_number
        fill_in 'party_password', with: password
      end
      click_button '登入'
    end

    def party_input_phone_number(phone_number)
      within('.edit_party') do
        fill_in 'party_unconfirmed_phone', with: phone_number
      end
    end

    def party_input_verify_code(verify_code)
      within('.edit_party') do
        fill_in 'party_phone_varify_code', with: verify_code
      end
    end

    def party_input_reset_password(identify_number, phone_number)
      within('#new_party') do
        fill_in 'party_identify_number', with: identify_number
        fill_in 'party_phone_number', with: phone_number
      end
    end

    def party_run_schedule_score_flow(story, schedule, judge)
      visit(input_info_party_score_schedules_path)
      party_input_info_schedule_score(story)
      party_input_date_schedule_score(schedule)
      party_input_judge_schedule_score(judge)
      party_create_schedule_score
    end

    def party_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'schedule_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'schedule_score_story_type'
      within('#new_schedule_score') do
        fill_in 'schedule_score_year', with: year ? year : story.year
        fill_in 'schedule_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'schedule_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def party_input_date_schedule_score(schedule)
      within('#new_schedule_score') do
        fill_in 'schedule_score_start_on', with: schedule.start_on
      end
      click_button '下一步'
    end

    def party_input_judge_schedule_score(judge)
      within('#new_schedule_score') do
        fill_in 'schedule_score_judge_name', with: judge.name
      end
      click_button '下一步'
    end

    def party_create_schedule_score
      choose('schedule_score_rating_score_20')
      within('#new_schedule_score') do
        fill_in 'schedule_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def party_edit_schedule_score
      visit(party_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def party_run_verdict_score_flow(story)
      visit(input_info_party_score_verdicts_path)
      party_input_info_verdict_score(story)
      party_create_verdict_score
    end

    def party_input_info_verdict_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'verdict_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'verdict_score_story_type'
      within('#new_verdict_score') do
        fill_in 'verdict_score_year', with: year ? year : story.year
        fill_in 'verdict_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'verdict_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def party_create_verdict_score
      choose('verdict_score_rating_score_20')
      within('#new_verdict_score') do
        fill_in 'verdict_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def party_edit_verdict_score
      visit(party_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def open_party_email(email)
      perform_sidekiq_job(fetch_sidekiq_last_job)
      open_email(email)
    end
  end
end
