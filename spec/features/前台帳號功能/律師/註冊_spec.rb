require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  def lawyer_register(name, email)
    visit(new_lawyer_registration_path)
    lawyer_input_registration_form(name, email)
    click_button '註冊'
  end

  def lawyer_set_password(email, password: nil, password_confirmation: nil)
    open_lawyer_email(email)
    current_email.find('a').click
    lawyer_input_set_password_form(password: password, password_confirmation: password_confirmation)
    click_button '送出'
  end

  feature '律師' do
    feature '註冊' do
      let(:lawyer) { create :lawyer }
      Scenario '資料庫有未完成註冊的律師，才能成功註冊' do
        Given '律師A未完成註冊' do
          When '以律師A資料進行註冊' do
            before { lawyer_register(lawyer.name, lawyer.email) }
            Then '註冊成功、送出密碼設定信' do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content('確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。')
            end
          end
        end
      end

      Scenario '已完成註冊的律師，無法重複註冊' do
        Given '律師A已完成註冊' do
          let(:lawyer) { create :lawyer, :with_confirmed }
          When '以律師A資料進行註冊' do
            before { lawyer_register(lawyer.name, lawyer.email) }
            Then '註冊失敗' do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content('已經註冊 請直接登入')
            end
          end
        end
      end

      Scenario '資料庫不存在的資料無法進行註冊' do
        Given '資料庫無律師資料' do
          When '以任何符合驗證的律師資料進行註冊' do
            before { lawyer_register('王小明', '55669487@gmail.com') }
            Then '註冊失敗' do
              expect(current_path).to match(lawyer_registration_path)
              expect(page).to have_content('查無此律師資料 請改以人工管道註冊')
            end
          end
        end
      end

      Scenario '完成密碼設定才算是完成註冊，否則可以重複寄出密碼設定信以完成註冊' do
        Given '律師A未完成註冊、且已註冊成功送出密碼信' do
          before { lawyer_register(lawyer.name, lawyer.email) }
          When '以律師A資料重新進行註冊' do
            before { lawyer_register(lawyer.name, lawyer.email) }
            Then '註冊成功、送出密碼設定信' do
              expect(current_path).to match(new_lawyer_session_path)
              expect(page).to have_content('確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。')
            end
          end
        end
      end

      Scenario '律師A成功設定密碼後會自動登入' do
        Given '律師A申請註冊成功送出密碼信' do
          before { lawyer_register(lawyer.name, lawyer.email) }
          When '密碼設定成功' do
            before { lawyer_set_password(lawyer.email, password: '11111111', password_confirmation: '11111111') }
            Then '自動登入 並導向到律師首頁' do
              expect(current_path).to match(lawyer_root_path)
              expect(page).to have_content('您的密碼已被修改。')
            end
          end
        end
      end
    end
  end
end
