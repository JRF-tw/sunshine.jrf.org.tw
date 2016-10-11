module Capybara
  module ObserverHelper
    def capybara_input_sign_up_observer(observer_data)
      within("#new_court_observer") do
        fill_in "court_observer_name", with: observer_data[:name]
        fill_in "court_observer_email", with: observer_data[:email]
        fill_in "court_observer_password", with: observer_data[:password]
        fill_in "court_observer_password_confirmation", with: observer_data[:password]
      end
      check("policy_agreement")
      save_page
    end

    def capybara_input_sign_in_observer(observer_data)
      within("#new_court_observer") do
        fill_in "court_observer_email", with: observer_data[:email]
        fill_in "court_observer_password", with: observer_data[:password]
      end
      save_page
    end

    def capybara_regiter_submit_observer
      click_button "註冊"
      save_page
    end

    def capybara_confirm_observer(email)
      perform_sidekiq_job(fetch_sidekiq_last_job)
      open_email(email)
      current_email.find("a").click
    end

    def capybara_log_in_observer
      click_button "登入"
      save_page
    end

    def capybara_signin_court_observer(court_observer)
      visit(new_court_observer_session_path)
      within("#new_court_observer") do
        fill_in "court_observer_email", with: court_observer.email
        fill_in "court_observer_password", with: court_observer.password
      end
      click_button "登入"
    end

    def capybara_court_observer_run_schedule_score_flow(story, schedule, judge)
      visit(input_info_court_observer_score_schedules_path)
      capybara_court_observer_input_info_schedule_score(story)
      capybara_court_observer_input_date_schedule_score(schedule)
      capybara_court_observer_input_judge_schedule_score(judge)
      capybara_court_observer_create_schedule_score
    end

    def capybara_court_observer_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil)
      select court ? court.full_name.to_s : story.court.full_name.to_s, from: "schedule_score_court_id"
      within("#new_schedule_score") do
        fill_in "schedule_score_year", with: year ? year : story.year
        fill_in "schedule_score_word_type", with: word_type ? word_type : story.word_type
        fill_in "schedule_score_number", with: number ? number : story.number
      end
      click_button "下一步"
    end

    def capybara_court_observer_input_date_schedule_score(schedule)
      within("#new_schedule_score") do
        fill_in "schedule_score_start_on", with: schedule.start_on
      end
      click_button "下一步"
    end

    def capybara_court_observer_input_judge_schedule_score(judge)
      within("#new_schedule_score") do
        fill_in "schedule_score_judge_name", with: judge.name
      end
      click_button "下一步"
    end

    def capybara_court_observer_create_schedule_score
      choose("schedule_score_rating_score_20")
      within("#new_schedule_score") do
        fill_in "schedule_score_note", with: "test"
      end
      click_button "送出評鑑"
    end

    def capybara_court_observer_edit_schedule_score
      visit(court_observer_root_path)
      find(:xpath, "//tbody/tr/td/a").click
      sleep 1
      click_link("編輯評鑑")
      sleep 1
    end

    def capybara_court_observer_run_verdict_score_flow
      visit(new_court_observer_score_verdict_path)
    end
  end
end
