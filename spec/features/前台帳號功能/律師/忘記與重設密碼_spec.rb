require 'rails_helper'
feature '前台帳號功能', type: :feature, js: true do
  feature '律師' do
    def send_reset_password_email(email)
      visit(new_lawyer_password_path)
      within('#new_lawyer') do
        fill_in 'lawyer_email', with: email
      end
      click_button '送出'
    end

    def visit_reset_password_page(email)
      open_lawyer_email(email)
      current_email.find('a').click
    end

    feature '忘記與重設密碼' do
      let(:lawyer_A) { create :lawyer, :with_password, :with_confirmed }
      before { send_reset_password_email(lawyer_A.email) }
      feature '送出重設密碼信' do
        Scenario '只有完成註冊的律師才能重設密碼' do
          Given '律師A已完成註冊、律師B未完成註冊' do
            let(:lawyer_B) { create :lawyer }
            When '送出律師A重設密碼資料' do
              before { send_reset_password_email(lawyer_A.email) }
              Then '送出密碼重設信' do
                expect(current_path).to eq(new_lawyer_session_path)
                expect(page).to have_content('您將在幾分鐘後收到一封電子郵件，內有重新設定密碼的步驟說明。')
              end
            end
            When '送出律師B重設密碼資料' do
              before { send_reset_password_email(lawyer_B.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(lawyer_password_path)
                expect(page).to have_content('該帳號尚未註冊')
              end
            end
          end
        end
      end

      feature '重設密碼' do
        Scenario '重設密碼頁應顯示目前帳號資料，並且比對已登入者資料' do
          before { send_reset_password_email(lawyer_A.email) }
          Given '律師A已送出密碼重設信，且已登入律師A' do
            before { signin_lawyer(email: lawyer_A.email) }
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(lawyer_A.email) }
              Then '頁面應顯示律師A資料' do
                expect(current_path).to eq(edit_lawyer_password_path)
                expect(page).to have_content(lawyer_A.email)
                expect(page).to have_content(lawyer_A.name)
              end
            end
          end

          Given '律師A已送出密碼重設信，且未登入' do
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(lawyer_A.email) }
              Then '頁面應顯示律師A資料' do
                expect(current_path).to eq(edit_lawyer_password_path)
                expect(page).to have_content(lawyer_A.email)
                expect(page).to have_content(lawyer_A.name)
              end
            end
          end

          Given '律師A已送出密碼重設信，且已登入律師B' do
            let(:lawyer_B) { create :lawyer, :with_password, :with_confirmed }
            before { signin_lawyer(email: lawyer_B.email) }
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(lawyer_A.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(lawyer_profile_path)
                expect(page).to have_content('你僅能修改本人的帳號')
              end
            end
          end
        end

        Scenario '成功設定密碼後應自動登入' do
          Given '律師A重設密碼中、且已登入' do
            before { signin_lawyer(email: lawyer_A.email) }
            before { visit_reset_password_page(lawyer_A.email) }
            When '送出新密碼' do
              before { lawyer_input_set_password_form(password: '11111111', password_confirmation: '11111111') }
              before { click_button '送出' }
              Then '轉跳至律師A個人頁' do
                expect(current_path).to eq(lawyer_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end

          Given '律師A重設密碼中、且未登入' do
            before { visit_reset_password_page(lawyer_A.email) }
            When '送出新密碼' do
              before { lawyer_input_set_password_form(password: '11111111', password_confirmation: '11111111') }
              before { click_button '送出' }
              Then '轉跳至律師A個人頁' do
                expect(current_path).to eq(lawyer_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end
        end
      end
    end
  end
end
