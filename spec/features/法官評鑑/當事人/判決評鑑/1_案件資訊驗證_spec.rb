require 'rails_helper'
feature '法官評鑑 - 當事人', type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:court1) { create :court }
  let!(:story) { create :story, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:verdict) { create :verdict, story: story }
  before { signin_party(identify_number: party.identify_number) }

  feature '判決評鑑' do
    feature '案件資訊驗證' do
      Scenario '判決評鑑流程中，正在輸入案件資訊的頁面' do
        before { visit(input_info_party_score_verdicts_path) }
        Given '輸入該法院下的正確案件資訊' do
          before { party_input_info_verdict_score(story) }
          When '送出' do
            # party_input_info_verdict_score should not click
            Then 'Then 成功前往評分頁面' do
              expect(page).to have_content('判決流程評鑑')
            end
          end
        end

        Given '輸入非該法院下的正確案件資訊' do
          before { party_input_info_verdict_score(story, court: court1) }
          When '送出' do
            # party_input_info_verdict_score should not click
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(page).to have_selector('#verdict_score_court_id_chosen', text: court1.full_name)
              expect(page).to have_content('案件不存在')
            end
          end
        end

        Given '輸入不存在的案件資訊' do
          let!(:error_word_type) { '不存在字別' }
          before { party_input_info_verdict_score(story, word_type: error_word_type) }
          When '送出' do
            # party_input_info_verdict_score should not click
            Then '顯示錯誤訊息，頁面仍保留原始輸入資訊' do
              expect(page).to have_field('verdict_score_word_type', with: error_word_type)
              expect(page).to have_content('案件不存在')
            end
          end
        end
      end
    end
  end
end
