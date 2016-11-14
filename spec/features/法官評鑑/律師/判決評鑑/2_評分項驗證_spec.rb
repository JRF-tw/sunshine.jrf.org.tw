require 'rails_helper'
feature '法官評鑑 - 律師', type: :feature, js: true do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:verdict) { create :verdict, story: story, is_judgment: true }
  before { signin_lawyer(email: lawyer.email, password: lawyer.password) }

  feature '判決評鑑' do
    feature '評分項驗證' do
      Scenario '判決評鑑流程中，正在輸入評分項的頁面' do
        before { visit(input_info_lawyer_score_verdicts_path) }
        before { lawyer_input_info_verdict_score(story) }

        Given '律師 選擇「裁判品質」評分' do
          before { choose('verdict_score_score_3_1_20') }
          before { 6.times.each_with_index { |i| choose("verdict_score_score_3_2_#{i + 1}_100") } }
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示感謝頁面' do
              expect(page).to have_content('感謝您的評鑑')
            end
          end
        end

        Given '律師 未選擇「裁判品質」評分' do
          When '送出' do
            before { click_button '送出評鑑' }
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(find_field('verdict_score_score_3_1_20')).not_to be_checked
              expect(page).to have_content('裁判品質分數為必填')
            end
          end
        end
      end
    end
  end
end
