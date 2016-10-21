require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '律師' do
    feature '登入' do
      Scenario '律師在完成註冊後進行登入' do
        let!(:lawyer) { create :lawyer, :with_confirmed, :with_password }
        Given "無律師登入" do
          When "律師登入" do
            before { signin_lawyer(email: lawyer.email, password: "123123123") }
            Then "登入成功" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content('成功登入了')
            end
          end
        end

        Given "有律師登入" do
          before { signin_lawyer(email: lawyer.email, password: "123123123") }
          When "前往律師登入頁面" do
            before { visit(new_lawyer_session_path) }
            Then '頁面轉跳' do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content('您已經登入。')
            end
          end
        end
      end

      Scenario '律師尚未完成註冊進行登入' do
        Given '資料庫有律師資料，包含登入帳號和密碼，但尚未完成註冊' do
          let!(:lawyer) { create :lawyer, :with_password }
          When "律師以正確的帳號資訊進行登入" do
            before { signin_lawyer(email: lawyer.email, password: "123123123") }
            Then "登入失敗，頁面轉跳" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content('您的帳號需要經過驗證後，才能繼續。')
            end
          end
        end

        Given "資料庫無該律師資料" do
          When "律師登入" do
            before { signin_lawyer(email: "5566@gmail.com", password: "123123123") }
            Then "登入失敗，頁面轉跳" do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content('輸入資訊是無效的。')
            end
          end
        end
      end
    end
  end
end
