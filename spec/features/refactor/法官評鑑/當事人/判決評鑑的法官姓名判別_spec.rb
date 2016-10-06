require "rails_helper"
feature "法官評鑑 - 當事人", type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:verdict) { create :verdict, story: story, main_judge: judge, is_judgment: true }
  before { capybara_signin_party(party) }

  feature "判決評鑑的法官姓名判別" do
    Scenario "判決評鑑流程中，正在輸入法官姓名的頁面" do
      before { visit(input_info_party_score_verdicts_path) }
      before { capybara_party_input_info_verdict_score(story) }
      Given "輸入判決書內審判長法官的姓名" do
        before do
          within("#new_verdict_score") do
            fill_in "verdict_score_judge_name", with: judge.name
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "成功前往下一步（頁）" do
            expect(page).to have_content("判決流程評鑑")
          end
        end
      end

      Given "輸入「非」判決書內審判長法官的姓名" do
        let(:judge1) { create :judge, court: court }
        before do
          within("#new_verdict_score") do
            fill_in "verdict_score_judge_name", with: judge1.name
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_field("verdict_score_judge_name", with: judge1.name)
            expect(page).to have_content("判決書比對法官名稱錯誤")
          end
        end
      end
    end
  end
end
