module Capybara
  module ObserverHelper
    def court_observer_input_sign_up(observer_data)
      within('#new_court_observer') do
        fill_in 'court_observer_name', with: observer_data[:name]
        fill_in 'court_observer_email', with: observer_data[:email]
        fill_in 'court_observer_password', with: observer_data[:password]
        fill_in 'court_observer_password_confirmation', with: observer_data[:password]
      end
      check('policy_agreement')
      save_page
    end

    def court_observer_input_resend_password_email(email)
      within('#new_court_observer') do
        fill_in 'court_observer_email', with: email
      end
    end

    def court_observer_input_set_password(password:, password_confirmation: nil)
      within('#new_court_observer') do
        fill_in 'court_observer_password', with: password
        fill_in 'court_observer_password_confirmation', with: password_confirmation || password
      end
    end

    def court_observer_input_edit_email(email:, password: '123123123')
      within('#edit_court_observer') do
        fill_in 'court_observer_email', with: email
        fill_in 'court_observer_current_password', with: password
      end
    end

    def regiter_submit_observer
      click_button '註冊'
      save_page
    end

    def confirm_observer(email)
      perform_sidekiq_job(fetch_sidekiq_jobs(Devise::Async::Backend::Sidekiq).last)
      open_email(email)
      current_email.find('a').click
    end

    def signin_court_observer(email:, password: '123123123')
      visit(new_court_observer_session_path)
      within('#new_court_observer') do
        fill_in 'court_observer_email', with: email
        fill_in 'court_observer_password', with: password
      end
      click_button '登入'
    end

    def court_observer_run_schedule_score_flow(story, schedule, judge)
      visit(input_info_court_observer_score_schedules_path)
      court_observer_input_info_schedule_score(story)
      court_observer_input_date_schedule_score(schedule)
      court_observer_input_judge_schedule_score(judge)
      court_observer_create_schedule_score
    end

    def court_observer_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name.to_s : story.court.full_name.to_s, from: 'schedule_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'schedule_score_story_type'
      within('#new_schedule_score') do
        fill_in 'schedule_score_year', with: year ? year : story.year
        fill_in 'schedule_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'schedule_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def court_observer_input_date_schedule_score(schedule)
      within('#new_schedule_score') do
        fill_in 'schedule_score_start_on', with: schedule.start_on
      end
      click_button '下一步'
    end

    def court_observer_input_judge_schedule_score(judge)
      within('#new_schedule_score') do
        fill_in 'schedule_score_judge_name', with: judge.name
      end
      click_button '下一步'
    end

    def court_observer_create_schedule_score
      3.times.each_with_index { |i| choose("schedule_score_score_1_#{i + 1}_20") }
      within('#new_schedule_score') do
        fill_in 'schedule_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def court_observer_edit_schedule_score
      visit(court_observer_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def court_observer_run_verdict_score_flow
      visit(new_court_observer_score_verdict_path)
    end
  end
end
