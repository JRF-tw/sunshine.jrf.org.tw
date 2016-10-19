require "rails_helper"

feature "前台帳號功能", type: :feature, js: true do
  feature "律師" do
    feature "註冊" do
      let(:lawyer) { create :lawyer }
      Scenario "資料庫有未完成註冊的律師，才能成功註冊" do
        Given "律師A未完成註冊" do
          When "以律師A資料進行註冊" do
            before { register_lawyer_with(lawyer.name, lawyer.email) }
            Then "註冊成功、送出密碼設定信" do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")
            end
          end
        end
      end

      Scenario "已完成註冊的律師，無法重複註冊" do
        Given "律師A已完成註冊" do
          before { lawyer.confirm! }
          When "以律師A資料進行註冊" do
            before { register_lawyer_with(lawyer.name, lawyer.email) }
            Then "註冊失敗" do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content("已經註冊 請直接登入")
            end
          end
        end
      end

      Scenario "資料庫不存在的資料無法進行註冊" do
        Given "資料庫無律師資料" do
          When "以任何符合驗證的律師資料進行註冊" do
            before { register_lawyer_with("王小明", "55669487@gmail.com") }
            Then "註冊失敗" do
              expect(current_path).to match(lawyer_registration_path)
              expect(page).to have_content("查無此律師資料 請改以人工管道註冊")
            end
          end
        end
      end

      Scenario "完成密碼設定才算是完成註冊，否則可以重複寄出密碼設定信以完成註冊" do
        Given "律師A未完成註冊、且已註冊成功送出密碼信" do
          before { register_lawyer_with(lawyer.name, lawyer.email) }
          When "以律師A資料重新進行註冊" do
            before { register_lawyer_with(lawyer.name, lawyer.email) }
            Then "註冊成功、送出密碼設定信" do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")
            end
          end
        end
      end
    end
  end
end
