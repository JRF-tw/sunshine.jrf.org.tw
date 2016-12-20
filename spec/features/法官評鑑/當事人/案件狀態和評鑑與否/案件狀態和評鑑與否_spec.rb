require 'rails_helper'
feature '法官評鑑 - 當事人', type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:schedule) { create :schedule, :court_with_judge }
  let(:story) { schedule.story }
  before { signin_party(identify_number: party.identify_number) }

  feature '案件的狀態和評鑑與否' do
    Scenario '案件尚未抓到判決書 (即沒有判決日)' do
      before { story.update_attributes(is_adjudge: false) }
      Given '案件無宣判日' do
        When '進行新增開庭評鑑' do
          before { party_run_schedule_score_flow(schedule) }
          Then '成功新增開庭評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行編輯開庭評鑑' do
          before { party_run_schedule_score_flow(schedule) }
          before { party_edit_schedule_score }
          before { click_button '更新評鑑' }
          Then '成功編輯開庭評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行新增判決評鑑' do
          before { visit(input_info_party_score_verdicts_path) }
          before { party_input_info_verdict_score(story) }
          Then '無法進行' do
            expect(page).to have_content('尚未抓到判決書')
          end
        end
      end

      Given '案件的宣判日在未來' do
        before { story.update_attributes(pronounce_date: Time.zone.today + 1.day) }
        When '進行新增開庭評鑑' do
          before { party_run_schedule_score_flow(schedule) }
          Then '成功新增開庭評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行編輯開庭評鑑' do
          before { party_run_schedule_score_flow(schedule) }
          before { party_edit_schedule_score }
          before { click_button '更新評鑑' }
          Then '成功編輯開庭評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行新增判決評鑑' do
          before { visit(input_info_party_score_verdicts_path) }
          before { party_input_info_verdict_score(story) }
          Then '無法進行' do
            expect(page).to have_content('尚未抓到判決書')
          end
        end
      end

      Given '案件的宣判日在過去' do
        before { story.update_attributes(pronounce_date: Time.zone.today - 1.day) }
        When '進行新增開庭評鑑' do
          before { visit(input_info_party_score_schedules_path) }
          before { party_input_info_schedule_score(story) }
          Then '無法進行' do
            expect(page).to have_content('案件已宣判, 無法評鑑')
          end
        end

        When '進行新增判決評鑑' do
          before { visit(input_info_party_score_verdicts_path) }
          before { party_input_info_verdict_score(story) }
          Then '無法進行' do
            expect(page).to have_content('尚未抓到判決書')
          end
        end
      end
    end

    Scenario '案件已抓到判決書，且宣判日在過去或當天' do
      before { story.update_attributes(is_adjudge: true, is_pronounce: true) }
      Given '判決日與宣判日在當天' do
        before { story.update_attributes(adjudge_date: Time.zone.today) }
        before { story.update_attributes(pronounce_date: Time.zone.today) }

        When '進行新增開庭評鑑' do
          before { visit(input_info_party_score_schedules_path) }
          before { party_input_info_schedule_score(story) }
          Then '無法進行' do
            expect(page).to have_content('已有判決書, 不可評鑑開庭')
          end
        end

        When '進行新增判決評鑑' do
          before { party_run_verdict_score_flow(story) }
          Then '成功新增判決評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行編輯判決評鑑' do
          before { party_run_verdict_score_flow(story) }
          before { party_edit_verdict_score }
          before { click_button '更新評鑑' }
          Then '成功編輯判決評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end
      end

      Given '判決日在三個月內的過去，宣判日在三個月外的過去' do
        before { story.update_attributes(adjudge_date: Time.zone.today - 2.months) }
        before { story.update_attributes(pronounce_date: Time.zone.today - 4.months) }
        When '進行新增開庭評鑑' do
          before { visit(input_info_party_score_schedules_path) }
          before { party_input_info_schedule_score(story) }
          Then '無法進行' do
            expect(page).to have_content('案件已宣判, 無法評鑑')
          end
        end

        When '進行新增判決評鑑' do
          before { party_run_verdict_score_flow(story) }
          Then '成功新增判決評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end

        When '進行編輯判決評鑑' do
          before { party_run_verdict_score_flow(story) }
          before { party_edit_verdict_score }
          before { click_button '更新評鑑' }
          Then '成功編輯判決評鑑' do
            expect(page).to have_content('感謝您的評鑑')
          end
        end
      end

      Given '判決日在三個月外的過去，宣判日在三個月外的過去' do
        before { story.update_attributes(adjudge_date: Time.zone.today - 4.months) }
        before { story.update_attributes(pronounce_date: Time.zone.today - 4.months) }
        When '進行新增開庭評鑑' do
          before { visit(input_info_party_score_schedules_path) }
          before { party_input_info_schedule_score(story) }
          Then '無法進行' do
            expect(page).to have_content('案件已宣判, 無法評鑑')
          end
        end

        When '進行新增判決評鑑' do
          before { visit(input_info_party_score_verdicts_path) }
          before { party_input_info_verdict_score(story) }
          Then '無法進行' do
            expect(page).to have_content('已超過可評鑑時間')
          end
        end
      end
    end
  end
end
