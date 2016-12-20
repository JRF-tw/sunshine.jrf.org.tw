require 'rails_helper'

feature '法官評鑑 - 旁觀者', type: :feature, js: true do
  let!(:court_observer) { create :court_observer }
  let!(:schedule) { create :schedule, :court_with_judge }
  before { signin_court_observer(email: court_observer.email) }

  feature '開庭評鑑' do
    Scenario '完成評鑑後' do
      Given '旁觀者 已完成開庭評鑑，位於感謝頁' do
        before { court_observer_run_schedule_score_flow(schedule) }
        When '點擊「評鑑其他法官」' do
          before { click_button '評鑑其他法官' }
          Then '轉跳至開庭評鑑流程中的法官姓名輸入頁' do
            expect(page).to have_content('輸入法官姓名')
            expect(current_path).to eq('/observer/score/schedules/input_judge')
          end
        end
      end
    end
  end
end
