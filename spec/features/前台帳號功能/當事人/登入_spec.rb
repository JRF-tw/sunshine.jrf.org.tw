require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    feature '登入' do
      Scenario '以身分證字號做為登入帳號' do
        Given '當事人已註冊' do
          let(:party) { create :party }
          When '正確的身分證字號和密碼登入' do
            before { signin_party(identify_number: party.identify_number, password: party.password) }
            Then '登入成功' do
              expect(current_path).to match(party_root_path)
              expect(page).to have_content('成功登入了。')
            end
          end

          When '正確的身分證字號和錯誤的密碼登入' do
            before { signin_party(identify_number: party.identify_number, password: '55669487') }
            Then '登入失敗' do
              expect(current_path).to match(party_session_path)
              expect(page).to have_content('身分證或密碼是無效的。')
            end
          end
        end
      end
    end
  end
end
