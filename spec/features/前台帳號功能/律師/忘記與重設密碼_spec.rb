require "rails_helper"
feature "前台帳號功能", type: :feature, js: true do
  feature "律師" do
    feature "忘記密碼" do
      feature "送出重設密碼信" do
        Scenario "只有完成註冊的律師才能重設密碼" do
          Given "律師A已完成註冊、律師B未完成註冊" do
            When "送出律師A重設密碼資料" do
              Then "送出密碼重設信" do
              end
            end
            When "送出律師B重設密碼資料" do
              Then "顯示錯誤訊息" do
              end
            end
          end
        end
      end

      feature "重設密碼" do
        Scenario "重設密碼頁應顯示目前帳號資料，並且比對已登入者資料" do
          Given "律師A已送出密碼重設信，且已登入律師A" do
            When "前往 Email 中密碼重設頁" do
              Then "頁面應顯示律師A資料" do
              end
            end
          end

          Given "律師A已送出密碼重設信，且未登入" do
            When "前往 Email 中密碼重設頁" do
              Then "頁面應顯示律師A資料" do
              end
            end
          end

          Given "律師A已送出密碼重設信，且已登入律師B" do
            When "前往 Email 中密碼重設頁" do
              Then "顯示錯誤訊息" do
              end
            end
          end
        end

        Scenario "成功設定密碼後應自動登入" do
          Given "律師A重設密碼中、且已登入" do
            When "送出新密碼" do
              Then "轉跳至律師A個人頁" do
              end
            end
          end

          Given "律師A重設密碼中、且未登入" do
            When "送出新密碼" do
              Then "轉跳至律師A個人頁" do
              end
            end
          end
        end
      end
    end
  end
end
