require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '觀察者' do
    def click_confirm_link(email)
      open_last_email(email)
      current_email.find('a').click
    end

    def edit_email(email)
      visit(edit_court_observer_email_path)
      court_observer_input_edit_email(email: email)
      click_button '送出'
    end

    def sign_out_after_edit_email(observer, email:)
      signin_court_observer(email: observer.email)
      edit_email(email)
      manual_http_request(:delete, '/observer/sign_out')
    end

    feature '更改 Email' do
      let!(:observer_A) { create :court_observer }
      feature '送出新 Email 認證' do
        Scenario '觀察者A已登入，且觀察者A的新 Email 不能和任何人（包含自己）已認證的 Email 一樣' do
          before { signin_court_observer(email: observer_A.email) }
          Given '觀察者B已註冊，但尚未通過 Email 認證' do
            let!(:observer_B) { create :court_observer, :without_confirm }
            When '觀察者A的新 Email 和觀察者B一樣' do
              before { edit_email(observer_B.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(court_observer_email_path)
                expect(page).to have_content('email 已被使用')
              end
            end
          end

          Given '觀察者B已完成註冊，正在認證新 Email `xx@xx.com`' do
            let!(:observer_B) { create :court_observer, :with_unconfirmed_email }
            When '觀察者A的新 Email 為 `xx@xx.com`' do
              before { edit_email(observer_B.unconfirmed_email) }
              Then '成功送出' do
                expect(current_path).to eq(court_observer_profile_path)
                expect(page).to have_content('需要重新驗證新的Email')
              end
            end
          end

          Given '觀察者A的登入 Email 為 `xx@xx.com`' do
            When '觀察者A的新 Email 為 `xx@xx.com`' do
              before { edit_email(observer_A.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(court_observer_email_path)
                expect(page).to have_content('email 不可與原本相同')
              end
            end
          end
        end
      end

      feature '點擊連結後，新 Email 代換為登入 Email' do
        let!(:observer_A) { create :court_observer }
        let!(:observer_B) { create :court_observer }
        Scenario '觀察者A已送出新 Email 的認證信。登入狀態與否不影響認證連結結果。但相同的 Email 會是「先認證先贏」' do
          before { sign_out_after_edit_email(observer_A, email: '4545@gmail.com') }
          Given '觀察者A已登入' do
            before { signin_court_observer(email: observer_A.email) }
            When '前往認證連結' do
              before { click_confirm_link(observer_A.reload.unconfirmed_email) }
              Then '觀察者A的 Email 成功代換' do
                expect(current_path).to eq(court_observer_root_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '觀察者A未登入' do
            When '前往認證連結' do
              before { click_confirm_link(observer_A.reload.unconfirmed_email) }
              Then '觀察者A的 Email 成功代換' do
                expect(current_path).to eq(new_court_observer_session_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '觀察者B已登入' do
            before { signin_court_observer(email: observer_B.email) }
            When '前往認證連結' do
              before { click_confirm_link(observer_A.reload.unconfirmed_email) }
              Then '觀察者A的 Email 成功代換、觀察者B則不受影響' do
                expect(current_path).to eq(court_observer_root_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '觀察者A和觀察者B送出相同的 Email 進行認證，且 B 已前往認證連結完成代換' do
            before { sign_out_after_edit_email(observer_B, email: '4545@gmail.com') }
            before { click_confirm_link(observer_B.reload.unconfirmed_email) }
            When '前往觀察者A的認證連結' do
              before { click_confirm_link(observer_A.reload.unconfirmed_email) }
              Then '觀察者A的 Email 代換失敗' do
                expect(current_path).to eq(new_court_observer_session_path)
                expect(page).to have_content('已經驗證，請直接登入。')
              end
            end
          end
        end
      end
    end
  end
end
