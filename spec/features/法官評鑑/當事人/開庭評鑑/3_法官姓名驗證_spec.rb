require 'rails_helper'
feature '法官評鑑 - 當事人', type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:court1) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:schedule) { create :schedule, court: court, story: story }
  before { capybara_signin_party(party) }

  feature '開庭評鑑' do
    feature '法官姓名驗證' do
      Scenario '開庭評鑑流程中，正在輸入法官姓名的頁面' do
        before { visit(input_info_party_score_schedules_path) }
        before { capybara_party_input_info_schedule_score(story) }
        before { capybara_party_input_date_schedule_score(schedule) }

        Given '輸入該案件法院下、且為庭期內股別所對應的法官姓名' do
          before do
            within('#new_schedule_score') do
              fill_in 'schedule_score_judge_name', with: judge.name
            end
          end
          When '送出' do
            before { click_button '下一步' }
            Then '成功前往下一步（頁）' do
              expect(page).to have_content('開庭流程評鑑')
            end
          end
        end

        Given '輸入該案件法院下、但非庭期內股別所對應的法官姓名' do
          let!(:judge1) { create :judge, court: court }
          before do
            within('#new_schedule_score') do
              fill_in 'schedule_score_judge_name', with: judge1.name
            end
          end
          When '送出' do
            before { click_button '下一步' }
            Then '成功前往下一步（頁）' do
              expect(page).to have_content('開庭流程評鑑')
            end
          end
        end

        Given '輸入不存在的法官姓名' do
          let!(:fake_name) { '不存在法官名稱' }
          before do
            within('#new_schedule_score') do
              fill_in 'schedule_score_judge_name', with: fake_name
            end
          end
          When '送出' do
            before { click_button '下一步' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(page).to have_field('schedule_score_judge_name', with: fake_name)
              expect(page).to have_content('沒有該位法官')
            end
          end
        end

        Given '輸入非隸屬該法院的法官姓名' do
          let!(:judge1) { create :judge }
          before do
            within('#new_schedule_score') do
              fill_in 'schedule_score_judge_name', with: judge1.name
            end
          end
          When '送出' do
            before { click_button '下一步' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(page).to have_field('schedule_score_judge_name', with: judge1.name)
              expect(page).to have_content('法官不存在該法院')
            end
          end
        end
      end
    end
  end
end
