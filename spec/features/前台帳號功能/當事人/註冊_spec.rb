require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    def register_name_and_id(name:, identify_number:)
      visit(new_party_registration_path)
      party_input_name_and_id(name, identify_number)
      click_button '下一步'
    end

    def register_password(password:, password_confirmation: nil)
      party_input_password(password, password_confirmation)
      click_button '註冊'
    end
    feature '註冊' do
      Scenario '僅身分證字號不能重複，且格式必須正確，加上必填資訊後即算完成註冊' do
        let!(:party) { create :party }
        Given '當事人進行註冊中' do
          When '輸入已註冊的身分證字號' do
            before { register_name_and_id(name: '咕嚕', identify_number: party.identify_number) }
            Then '註冊失敗' do
              expect(current_path).to match(party_registrations_check_identify_number_path)
              expect(page).to have_content('此身分證字號已經被使用 人工申訴連結')
            end
          end

          When '輸入不存在的身分證字號，但格式不符' do
            before { register_name_and_id(name: '咕嚕', identify_number: 'AAA112212') }
            Then '註冊失敗' do
              expect(current_path).to match(party_registrations_check_identify_number_path)
              expect(page).to have_content('身分證字號格式不符(英文字母請大寫)')
            end
          end

          When '輸入不存在的身分證字號，且符合格式' do
            before { register_name_and_id(name: '咕嚕', identify_number: 'A127216262') }
            before { register_password(password: '00000000') }
            Then '註冊成功' do
              expect(current_path).to match(new_party_phone_path)
              expect(page).to have_content('註冊成功，歡迎！')
            end
          end
        end
      end
    end
  end
end
