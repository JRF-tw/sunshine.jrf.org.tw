require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '觀察者' do
    feature '登入' do
      Scenario '以 Email 做為登入帳號' do
        Given '觀察者已註冊' do
          let!(:observer) { create :court_observer }
          When '正確的 Email 和密碼登入' do
            before { signin_court_observer(email: observer.email) }
            Then '登入成功' do
              expect(current_path).to eq(court_observer_root_path)
              expect(page).to have_content('成功登入了')
            end
          end

          When '正確的 Email 和錯誤的密碼登入' do
            before { signin_court_observer(email: observer.email, password: '11111111') }
            Then '登入失敗' do
              expect(current_path).to eq(court_observer_session_path)
              expect(page).to have_content('信箱或密碼是無效的')
            end
          end
        end
      end
    end
  end
end
