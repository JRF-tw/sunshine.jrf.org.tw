require 'rails_helper'

feature '法官評鑑 - 當事人', type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:schedule) { create :schedule, :court_with_judge }
  before { signin_party(identify_number: party.identify_number) }

  feature '開庭評鑑' do
    Scenario '完成評鑑後' do
      Given '當事人 已完成開庭評鑑，位於感謝頁' do
        before { party_run_schedule_score_flow(schedule) }
        When '點擊「評鑑其他法官」' do
          before { click_button '評鑑其他法官' }
          Then '轉跳至開庭評鑑流程中的法官姓名輸入頁' do
            expect(page).to have_content('輸入法官姓名')
            expect(current_path).to eq('/party/score/schedules/input_judge')
          end
        end
      end
    end
  end
end
