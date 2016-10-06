require "rails_helper"
feature "法官評鑑 - 當事人", type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:schedule) { create :schedule, court: court, story: story }
  before { capybara_signin_party(party) }

  feature "開庭評鑑的開庭日期判別" do
    Scenario "開庭評鑑流程中，正在輸入開庭日期的頁面。「確認此日期為實際開庭日」不打勾" do
      before { visit(input_info_party_score_schedules_path) }
      before { capybara_party_input_info_schedule_score(story) }

      Given "輸入庭期表「有」的日期" do
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: schedule.start_on
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "成功前往下一步（頁）" do
            expect(page).to have_content("輸入法官姓名")
          end
        end
      end

      Given "輸入庭期表「沒有」的日期" do
        let(:fake_date) { schedule.start_on - 1.day }
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: fake_date
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_field("schedule_score_start_on", with: fake_date)
            expect(page).to have_content("查無此庭期")
          end
        end
      end

      Given "輸入庭期表「有」的日期 and 日期已超過期限（當事人：兩週內）" do
        before { Timecop.freeze(Time.zone.today + 15.days) }
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: schedule.start_on
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_field("schedule_score_start_on", with: schedule.start_on)
            expect(page).to have_content("已超過可評鑑時間")
          end
        end
      end
    end

    Scenario "開庭評鑑流程中，正在輸入開庭日期的頁面。「確認此日期為實際開庭日」打勾" do
      before { visit(input_info_party_score_schedules_path) }
      before { capybara_party_input_info_schedule_score(story) }
      before { check("schedule_score_confirmed_realdate") }

      Given "輸入庭期表「有」的日期" do
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: schedule.start_on
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "成功前往下一步（頁）" do
            expect(page).to have_content("輸入法官姓名")
          end
          xit "該評鑑的「確認此日期為實際開庭日」欄位自動改為「沒打勾」"
        end
      end

      Given "輸入庭期表「沒有」的日期" do
        let(:fake_date) { schedule.start_on - 1.day }
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: fake_date
          end
        end
        When "送出" do
          before { click_button "下一步" }
          Then "成功前往下一步（頁）" do
            expect(page).to have_content("輸入法官姓名")
          end
          xit "該 當是人 的「確認此日期為實際開庭日使用次數」+1"
        end
      end

      Given "輸入庭期表「沒有」的日期 and 日期已超過期限（當事人：兩週內）" do
        before { Timecop.freeze(Time.zone.today + 15.days) }
        before do
          within("#new_schedule_score") do
            fill_in "schedule_score_start_on", with: schedule.start_on
          end
        end

        When "送出" do
          before { click_button "下一步" }
          Then "顯示錯誤訊息，頁面仍保留原始輸入資訊" do
            expect(page).to have_field("schedule_score_start_on", with: schedule.start_on)
            expect(page).to have_content("已超過可評鑑時間")
          end
        end
      end
    end
  end
end
