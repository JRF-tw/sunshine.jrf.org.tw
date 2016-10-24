module Capybara
  module PartyHelper
    def capybara_signin_party(party)
      visit(new_party_session_path)
      within('#new_party') do
        fill_in 'party_identify_number', with: party.identify_number
        fill_in 'party_password', with: party.password
      end
      click_button '登入'
      party
    end

    def capybara_party_run_schedule_score_flow(story, schedule, judge)
      visit(input_info_party_score_schedules_path)
      capybara_party_input_info_schedule_score(story)
      capybara_party_input_date_schedule_score(schedule)
      capybara_party_input_judge_schedule_score(judge)
      capybara_party_create_schedule_score
    end

    def capybara_party_input_info_schedule_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'schedule_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'schedule_score_story_type'
      within('#new_schedule_score') do
        fill_in 'schedule_score_year', with: year ? year : story.year
        fill_in 'schedule_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'schedule_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def capybara_party_input_date_schedule_score(schedule)
      within('#new_schedule_score') do
        fill_in 'schedule_score_start_on', with: schedule.start_on
      end
      click_button '下一步'
    end

    def capybara_party_input_judge_schedule_score(judge)
      within('#new_schedule_score') do
        fill_in 'schedule_score_judge_name', with: judge.name
      end
      click_button '下一步'
    end

    def capybara_party_create_schedule_score
      choose('schedule_score_rating_score_20')
      within('#new_schedule_score') do
        fill_in 'schedule_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def capybara_party_edit_schedule_score
      visit(party_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end

    def capybara_party_run_verdict_score_flow(story)
      visit(input_info_party_score_verdicts_path)
      capybara_party_input_info_verdict_score(story)
      capybara_party_create_verdict_score
    end

    def capybara_party_input_info_verdict_score(story, court: nil, year: nil, word_type: nil, number: nil, story_type: nil)
      select_from_chosen court ? court.full_name : story.court.full_name, from: 'verdict_score_court_id'
      select_from_chosen story_type ? story_type : story.story_type, from: 'verdict_score_story_type'
      within('#new_verdict_score') do
        fill_in 'verdict_score_year', with: year ? year : story.year
        fill_in 'verdict_score_word_type', with: word_type ? word_type : story.word_type
        fill_in 'verdict_score_number', with: number ? number : story.number
      end
      click_button '下一步'
    end

    def capybara_party_create_verdict_score
      choose('verdict_score_rating_score_20')
      within('#new_verdict_score') do
        fill_in 'verdict_score_note', with: 'test'
      end
      click_button '送出評鑑'
    end

    def capybara_party_edit_verdict_score
      visit(party_root_path)
      find(:xpath, '//tbody/tr/td/a').click
      click_link('編輯評鑑')
    end
  end
end
