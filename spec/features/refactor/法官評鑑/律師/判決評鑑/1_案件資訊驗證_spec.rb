require "rails_helper"
feature "法官評鑑 - 律師", type: :feature, js: true do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:court1) { create :court }
  let!(:story) { create :story, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:verdict) { create :verdict, story: story, main_judge: judge, is_judgment: true }
  before { capybara_signin_lawyer(lawyer, password: lawyer.password) }

  feature "判決評鑑的案件資訊判別" do
    Scenario "判決評鑑流程中，正在輸入案件資訊的頁面" do
      before { visit(input_info_lawyer_score_verdicts_path) }
      Given "輸入該法院下的正確案件資訊" do
        before { capybara_lawyer_input_info_verdict_score(story) }
        When "送出" do
          before { click_button "下一步" }
          Then "成功前往下一步（頁）" do
            expect(page).to have_content("輸入法官姓名")
          end
        end
      end

      Given "輸入非該法院下的正確案件資訊" do
        before { capybara_lawyer_input_info_verdict_score(story, court: court1) }
        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_select("verdict_score_court_id", selected: court1.full_name)
            expect(page).to have_content("案件不存在")
          end
        end
      end

      Given "輸入不存在的案件資訊" do
        let!(:error_word_type) { "不存在字別" }
        before { capybara_lawyer_input_info_verdict_score(story, word_type: error_word_type) }
        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_field("verdict_score_word_type", with: error_word_type)
            expect(page).to have_content("案件不存在")
          end
        end
      end
    end
  end
end
