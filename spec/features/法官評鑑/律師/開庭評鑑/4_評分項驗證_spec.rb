require 'rails_helper'
feature '法官評鑑 - 律師', type: :feature, js: true do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:schedule) { create :schedule, court: court, story: story }
  before { signin_lawyer(email: lawyer.email, password: lawyer.password) }

  feature '開庭評鑑' do
    feature '評分項驗證' do
      Scenario '開庭評鑑流程中，正在輸入評分項的頁面' do
        before { visit(input_info_lawyer_score_schedules_path) }
        before { lawyer_input_info_schedule_score(story) }
        before { lawyer_input_date_schedule_score(schedule) }
        before { lawyer_input_judge_schedule_score(judge) }

        Given '律師 選擇「訴訟指揮」「開庭態度」評分' do
          before { choose('schedule_score_command_score_20') }
          before { choose('schedule_score_attitude_score_20') }
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示感謝頁面' do
              expect(page).to have_content('感謝您的評鑑')
            end
          end
        end

        Given '律師 未選擇「訴訟指揮」評分' do
          before { choose('schedule_score_attitude_score_20') }
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(find_field('schedule_score_attitude_score_20')).to be_checked
              expect(page).to have_content('訴訟指揮分數為必填')
            end
          end
        end

        Given '律師 未選擇「開庭態度」評分' do
          before { choose('schedule_score_command_score_20') }
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(find_field('schedule_score_command_score_20')).to be_checked
              expect(page).to have_content('開庭態度分數為必填')
            end
          end
        end
      end
    end
  end
end
