require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '觀察者' do
    feature '忘記密碼與重設密碼' do
      let!(:observer_A) { create :court_observer }
      def send_reset_password_email(email)
        visit(new_court_observer_password_path)
        court_observer_input_resend_password_email(email)
        click_button '送出'
      end

      def visit_reset_password_page(email)
        open_last_email(email)
        current_email.find('a').click
      end
      feature '送出重設密碼信' do
        Scenario '必須通過認證才能送出重設密碼信' do
          Given '觀察者已完成註冊認證' do
            When '送出觀察者重設密碼資料' do
              before { send_reset_password_email(observer_A.email) }
              Then '成功送出 轉跳至登入頁' do
                expect(current_path).to eq(new_court_observer_session_path)
                expect(page).to have_content('您將在幾分鐘後收到一封電子郵件，內有重新設定密碼的步驟說明。')
              end
            end
          end

          Given '觀察者尚未完成註冊認證' do
            let!(:observer_A) { create :court_observer, :without_confirm }
            When '送出觀察者重設密碼資料' do
              before { send_reset_password_email(observer_A.email) }
              Then '送出失敗' do
                expect(current_path).to eq(court_observer_password_path)
                expect(page).to have_content('此帳號尚未驗證')
              end
            end
          end
        end
      end

      feature '重設密碼' do
        Scenario '重設密碼頁應顯示目前帳號資料，並且比對已登入者資料' do
          Given '觀察者A已送出密碼重設信，且已登入觀察者A' do
            before { send_reset_password_email(observer_A.email) }
            before { signin_court_observer(email: observer_A.email) }
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(observer_A.email) }
              Then '頁面應顯示觀察者A資料' do
                expect(current_path).to eq(edit_court_observer_password_path)
                expect(page).to have_content(observer_A.email)
                expect(page).to have_content(observer_A.name)
              end
            end
          end

          Given '觀察者A已送出密碼重設信，且未登入' do
            before { send_reset_password_email(observer_A.email) }
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(observer_A.email) }
              Then '頁面應顯示觀察者A資料' do
                expect(current_path).to eq(edit_court_observer_password_path)
                expect(page).to have_content(observer_A.email)
                expect(page).to have_content(observer_A.name)
              end
            end
          end

          Given '觀察者A已送出密碼重設信，且已登入觀察者B' do
            let(:observer_B) { create :court_observer }
            before { send_reset_password_email(observer_A.email) }
            before { signin_court_observer(email: observer_B.email) }
            When '前往 Email 中密碼重設頁' do
              before { visit_reset_password_page(observer_A.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(court_observer_profile_path)
                expect(page).to have_content('你僅能修改本人的帳號')
              end
            end
          end
        end

        Scenario '成功設定密碼後應自動登入' do
          before { send_reset_password_email(observer_A.email) }
          Given '觀察者A重設密碼中、且已登入' do
            before { signin_court_observer(email: observer_A.email) }
            before { visit_reset_password_page(observer_A.email) }
            When '送出新密碼' do
              before { court_observer_input_set_password(password: '11111111') }
              before { click_button '送出' }
              Then '轉跳至觀察者A個人頁' do
                expect(current_path).to eq(court_observer_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end

          Given '觀察者A重設密碼中、且未登入' do
            before { visit_reset_password_page(observer_A.email) }
            When '送出新密碼' do
              before { court_observer_input_set_password(password: '11111111') }
              before { click_button '送出' }
              Then '轉跳至觀察者A個人頁' do
                expect(current_path).to eq(court_observer_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end
        end
      end
    end
  end
end
