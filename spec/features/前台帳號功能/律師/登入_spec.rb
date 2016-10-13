require "rails_helper"

feature "前台帳號功能", type: :feature, js: true do
  feature "律師" do
    feature "登入" do
      Scenario "律師在完成註冊後進行登入" do
        Given "無律師登入" do
          When "律師登入" do
            Then "登入成功" do
            end
          end
        end

        Given "有律師登入" do
          When "律師登入" do
            Then "登入失敗，頁面轉跳" do
            end
          end
        end
      end

      Scenario "律師尚未完成註冊進行登入" do
        Given "資料庫有律師資料，但尚未完成註冊" do
          When "律師登入，密碼為預設密碼" do
            Then "登入失敗，頁面轉跳" do
            end
          end
        end

        Given "律師登入密碼為預設密碼" do
          When "律師登入，密碼為預設密碼" do
            Then "登入失敗，頁面轉跳" do
            end
          end
        end
      end
    end
  end
end
