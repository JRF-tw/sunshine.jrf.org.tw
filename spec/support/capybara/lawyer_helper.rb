module Capybara
  module LawyerHelper
    def capybara_build_lawyer(lawyer_data = nil)
      lawyer_data ||= { name: "孔令則", phone: 33_381_841, email: "kungls@hotmail.com" }
      lawyer = Import::CreateLawyerContext.new(lawyer_data).perform
      lawyer
    end

    def capybara_setting_password_lawyer(lawyer, password:)
      lawyer.update_attributes(password: password)
      lawyer.confirm
    end

    def capybara_signin_lawyer(email:, password:)
      visit(new_lawyer_session_path)
      within("#new_lawyer") do
        fill_in "lawyer_email", with: email
        fill_in "lawyer_password", with: password
      end
      click_button "登入"
    end

    def capybara_submit_password_lawyer(password:)
      within("#new_lawyer") do
        fill_in "lawyer_password", with: password
        fill_in "lawyer_password_confirmation", with: password
      end
      click_button "送出"
    end

    def capybara_sign_out_lawyer
      click_link "登出"
    end

    def capybara_lawyer_run_schedule_score_flow(story, schedule, judge)
      visit(input_info_lawyer_score_schedules_path)
      capybara_lawyer_input_info_schedule_score(story)
      capybara_lawyer_input_date_schedule_score(schedule)
      capybara_lawyer_input_judge_schedule_score(judge)
      capybara_lawyer_create_schedule_score
    end

    def capybara_lawyer_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: "schedule_score_court_id"
      select_from_chosen story_type ? story_type : story.story_type, from: "schedule_score_story_type"
      within("#new_schedule_score") do
        fill_in "schedule_score_year", with: year ? year : story.year
        fill_in "schedule_score_word_type", with: word_type ? word_type : story.word_type
        fill_in "schedule_score_number", with: number ? number : story.number
      end
      click_button "下一步"
    end

    def capybara_lawyer_input_date_schedule_score(schedule)
      within("#new_schedule_score") do
        fill_in "schedule_score_start_on", with: schedule.start_on
      end
      click_button "下一步"
    end

    def capybara_lawyer_input_judge_schedule_score(judge)
      within("#new_schedule_score") do
        fill_in "schedule_score_judge_name", with: judge.name
      end
      click_button "下一步"
    end

    def capybara_lawyer_create_schedule_score
      choose("schedule_score_command_score_20")
      choose("schedule_score_attitude_score_20")
      within("#new_schedule_score") do
        fill_in "schedule_score_note", with: "test"
      end
      click_button "送出評鑑"
    end

    def capybara_lawyer_edit_schedule_score
      visit(lawyer_root_path)
      find(:xpath, "//tbody/tr/td/a").click
      sleep 1
      click_link("編輯評鑑")
      sleep 1
    end

    def capybara_lawyer_run_verdict_score_flow(story)
      visit(input_info_lawyer_score_verdicts_path)
      capybara_lawyer_input_info_verdict_score(story)
      capybara_lawyer_create_verdict_score
    end

    def capybara_lawyer_input_info_verdict_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: "verdict_score_court_id"
      select_from_chosen story_type ? story_type : story.story_type, from: "verdict_score_story_type"
      within("#new_verdict_score") do
        fill_in "verdict_score_year", with: year ? year : story.year
        fill_in "verdict_score_word_type", with: word_type ? word_type : story.word_type
        fill_in "verdict_score_number", with: number ? number : story.number
      end
      click_button "下一步"
    end

    def capybara_lawyer_create_verdict_score
      choose("verdict_score_quality_score_20")
      within("#new_verdict_score") do
        fill_in "verdict_score_note", with: "test"
      end
      click_button "送出評鑑"
    end

    def capybara_lawyer_edit_verdict_score
      visit(lawyer_root_path)
      find(:xpath, "//tbody/tr/td/a").click
      click_link("編輯評鑑")
    end
  end
end
