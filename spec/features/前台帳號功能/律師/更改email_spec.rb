require "rails_helper"

feature "前台帳號功能", type: :feature, js: true do
  featrue "律師" do
    feature "更改登入 Email" do
      feature "送出新的 Email 認證" do
        Scenario "律師A已登入，且律師A的新 Email 不能和任何人（包含自己）已認證的 Email 一樣" do
          Given "律師B已完成註冊" do
            When "新 Email 和律師B一樣" do
              Then "顯示錯誤訊息" do
              end
            end
          end

          Given "律師B尚未完成註冊" do
            When "新 Email 和律師B一樣" do
              Then "顯示錯誤訊息" do
              end
            end
          end

          Given "律師B已完成註冊、且正在認證 Email `xx@xx.com`" do
            When "新 Email 為 `xx@xx.com`" do
              Then "送出新 Email 認證信" do
              end
            end
          end

          Given "律師A的登入 Email 為 `xx@xx.com`" do
            When "新 Email 為 `xx@xx.com`" do
              Then "顯示錯誤訊息" do
              end
            end
          end
        end
      end

      feature "點擊連結後，新 Email 代換為登入 Email" do
        Scenario "律師A已送出新 Email 的認證信" do
          Given "律師A已登入" do
            When "前往認證連結" do
              Then "律師A的 Email 成功代換" do
              end
            end
          end

          Given "律師A未登入" do
            When "前往認證連結" do
              Then "律師A的 Email 成功代換" do
              end
            end
          end

          Given "律師B已登入" do
            When "前往認證連結" do
              Then "律師A的 Email 成功代換、律師B則不受影響" do
              end
            end
          end

          Given "律師B已更換 Email 為律師A的新Email" do
            When "前往認證連結" do
              Then "律師A的 Email 代換失敗" do
              end
            end
          end
        end
      end
    end
  end

end
