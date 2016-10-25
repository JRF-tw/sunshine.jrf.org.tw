require 'rails_helper'
feature '法官評鑑 - 當事人', type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:schedule) { create :schedule, court: court, story: story }
  before { signin_party(identify_number: party.identify_number) }

  feature '開庭評鑑' do
    feature '評分項驗證' do
      Scenario '開庭評鑑流程中，正在輸入評分項的頁面' do
        before { visit(input_info_party_score_schedules_path) }
        before { party_input_info_schedule_score(story) }
        before { party_input_date_schedule_score(schedule) }
        before { party_input_judge_schedule_score(judge) }

        Given '當事人 選擇「開庭滿意度」評分' do
          before { choose('schedule_score_rating_score_20') }
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示感謝頁面' do
              expect(page).to have_content('感謝您的評鑑')
            end
          end
        end

        Given '當事人 未選擇「開庭滿意度」評分' do
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(find_field('schedule_score_rating_score_20')).not_to be_checked
              expect(page).to have_content('開庭滿意度分數為必填')
            end
          end
        end
      end
    end
  end
end
