require "rails_helper"

feature "前台帳號功能", type: :feature, js: true do
  feature "律師" do
    feature "登入" do
      Scenario "律師在完成註冊後進行登入" do
        let!(:lawyer) { confirmed_lawyer(nil, "11111111") }
        Given "無律師登入" do
          When "律師登入" do
            before { capybara_signin_lawyer(lawyer, password: "11111111") }
            Then "登入成功" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content("成功登入了")
            end
          end
        end

        Given "有律師登入" do
          before { capybara_signin_lawyer(lawyer, password: "11111111") }
          When "律師登入" do
            before { visit(new_lawyer_session_path) }
            Then "登入失敗，頁面轉跳" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content("您已經登入。")
            end
          end
        end
      end

      Scenario "律師尚未完成註冊進行登入" do
        Given "資料庫有律師資料，但尚未完成註冊" do
          let!(:lawyer) { capybara_register_lawyer }
          When "律師登入，密碼為預設密碼" do
            before { capybara_signin_lawyer(lawyer, password: "11111111") }
            Then "登入失敗，頁面轉跳" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content("信箱或密碼是無效的。")
            end
          end
        end

        Given "資料庫無該律師資料" do
          let!(:lawyer) { Lawyer.new(attributes_for(:lawyer)) }
          When "律師登入，密碼為預設密碼" do
            before { capybara_signin_lawyer(lawyer, password: "11111111") }
            Then "登入失敗，頁面轉跳" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content("輸入資訊是無效的。")
            end
          end
        end
      end
    end
  end
end
