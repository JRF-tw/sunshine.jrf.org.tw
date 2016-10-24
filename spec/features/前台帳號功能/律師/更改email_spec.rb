require 'rails_helper'
feature '前台帳號功能', type: :feature, js: true do
  feature '律師' do
    def lawyer_click_confirm_link(email)
      open_lawyer_email(email)
      current_email.find('a').click
    end

    def lawyer_edit_email_with(email, password)
      visit(edit_lawyer_email_path)
      lawyer_input_edit_email_form(email, password)
      click_button '送出'
    end
    feature '更改 Email' do
      let!(:lawyer_A) { create :lawyer, :with_confirmed, :with_password }
      feature '送出新的 Email 認證' do
        Scenario '律師A已登入，且律師A的新 Email 不能和任何人（包含自己）已認證的 Email 一樣' do
          before { signin_lawyer(email: lawyer_A.email, password: '123123123') }
          Given '律師B已完成註冊' do
            let!(:lawyer_B) { create :lawyer, :with_confirmed, :with_password }
            When '新 Email 和律師B一樣' do
              before { lawyer_edit_email_with(lawyer_B.email, '123123123') }
              Then '顯示錯誤訊息' do
                expect(current_path).to match(lawyer_email_path)
                expect(page).to have_content('email 已被使用')
              end
            end
          end

          Given '律師B尚未完成註冊' do
            let!(:lawyer_B) { create :lawyer }
            When '新 Email 和律師B一樣' do
              before { lawyer_edit_email_with(lawyer_B.email, '123123123') }
              Then '顯示錯誤訊息' do
                expect(current_path).to match(lawyer_email_path)
                expect(page).to have_content('email 已被使用')
              end
            end
          end

          Given '律師B已完成註冊、且正在認證 Email `xx@xx.com`' do
            let!(:lawyer_B) { create :lawyer, :with_confirmed, :with_password }
            before { lawyer_B.update_attributes(unconfirmed_email: 'test@gmail.com') }
            When '新 Email 為 `xx@xx.com`' do
              before { lawyer_edit_email_with(lawyer_B.unconfirmed_email, '123123123') }
              Then '送出新 Email 認證信' do
                expect(current_path).to match(lawyer_profile_path)
                expect(page).to have_content('需要重新驗證新的Email')
              end
            end
          end

          Given '律師A的登入 Email 為 `xx@xx.com`' do
            When '新 Email 為 `xx@xx.com`' do
              before { lawyer_edit_email_with(lawyer_A.email, '123123123') }
              Then '顯示錯誤訊息' do
                expect(current_path).to match(lawyer_email_path)
                expect(page).to have_content('email 不可與原本相同')
              end
            end
          end
        end
      end

      feature '點擊連結後，新 Email 代換為登入 Email' do
        Scenario '律師A已送出新 Email 的認證信' do
          before { lawyer_A.update_attributes(email: 'test@gmail.com') }
          before { CustomDeviseMailer.delay.resend_confirmation_instructions(lawyer_A) }
          Given '律師A已登入' do
            before { signin_lawyer(email: lawyer_A.email, password: '123123123') }
            When '前往認證連結' do
              before { lawyer_click_confirm_link('test@gmail.com') }
              Then '律師A的 Email 成功代換' do
                expect(current_path).to match(lawyer_profile_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '律師A未登入' do
            When '前往認證連結' do
              before { lawyer_click_confirm_link('test@gmail.com') }
              Then '律師A的 Email 成功代換' do
                expect(current_path).to match(new_lawyer_session_path)
                expect(page).to have_content('您的帳號已通過驗證')
                expect(lawyer_A.reload.email).to eq('test@gmail.com')
              end
            end
          end
          Given '律師B已登入' do
            let!(:lawyer_B) { create :lawyer, :with_confirmed, :with_password, email: '55669487@gmail.com' }
            before { signin_lawyer(email: lawyer_B.email, password: '123123123') }
            When '前往認證連結' do
              before { lawyer_click_confirm_link('test@gmail.com') }
              Then '律師A的 Email 成功代換、律師B則不受影響' do
                expect(current_path).to match(lawyer_profile_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '律師B已更換 Email 為律師A的新Email' do
            let!(:lawyer_B) { create :lawyer, :with_confirmed, :with_password, email: lawyer_A.reload.unconfirmed_email }
            When '前往認證連結' do
              before { lawyer_click_confirm_link('test@gmail.com') }
              Then '律師A的 Email 代換失敗' do
                expect(lawyer_A.reload.email).not_to eq('test@gmail.com')
                expect(current_path).to match(new_lawyer_session_path)
              end
            end
          end
        end
      end
    end
  end

end
