require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    def send_reset_password_sms(identify_number:, phone_number:)
      visit(new_party_password_path)
      party_input_reset_password(identify_number, phone_number)
      click_button '送出'
    end

    def edit_password(password)
      party_input_password(password)
      click_button '送出'
    end

    feature '忘記與重設密碼' do
      feature '送出重設密碼簡訊' do
        let!(:party) { create :party, :already_confirmed, :with_confirmation_token }
        Scenario '必須輸入正確的身分證字號 & 手機號碼才能送出' do
          Given '當事人已完成註冊，且通過手機驗證' do
            When '送出當事人重設密碼資料' do
              before { send_reset_password_sms(identify_number: party.identify_number, phone_number: party.phone_number) }
              Then '送出密碼重設簡訊' do
                expect(current_path).to eq(new_party_session_path)
                expect(page).to have_content('已寄送簡訊')
              end
            end

            When '送出當事人的身分證字號、但手機號碼不正確' do
              before { send_reset_password_sms(identify_number: party.identify_number, phone_number: '2323') }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_password_path)
                expect(page).to have_content('手機號碼輸入錯誤')
              end
            end
          end
        end

        Scenario '必須通過手機驗證、且符合簡訊發送條件才能送出' do
          Given '當事人已完成註冊，通過手機驗證，但簡訊發送已達上限' do
            before { party.sms_sent_count.incr(2) }
            When '送出當事人重設密碼資料' do
              before { send_reset_password_sms(identify_number: party.identify_number, phone_number: party.phone_number) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_password_path)
                expect(page).to have_content('五分鐘內只能寄送兩次簡訊')
              end
            end
          end
        end
      end

      feature '重設密碼' do
        Scenario '重設密碼頁應顯示目前帳號資料，並且比對已登入者資料' do
          let!(:party_A) { create :party, :already_confirmed }
          let!(:token) { party_A.set_reset_password_token }
          Given '當事人已送出密碼重設簡訊，且已登入' do
            before { signin_party(identify_number: party_A.identify_number) }
            When '前往密碼重設頁' do
              before { visit(edit_party_password_path(reset_password_token: token)) }
              Then '頁面應顯示當事人資料' do
                expect(current_path).to eq(edit_party_password_path)
                expect(page).to have_content(party_A.name)
                expect(page).to have_content(party_A.identify_number)
              end
            end
          end

          Given '當事人已送出密碼重設簡訊，且未登入' do
            When '前往密碼重設頁' do
              before { visit(edit_party_password_path(reset_password_token: token)) }
              Then '頁面應顯示當事人A資料' do
                expect(current_path).to eq(edit_party_password_path)
                expect(page).to have_content(party_A.name)
                expect(page).to have_content(party_A.identify_number)
              end
            end
          end

          Given '當事人A已送出密碼重設簡訊，且已登入當事人B' do
            let!(:party_B) { create :party, :already_confirmed }
            before { signin_party(identify_number: party_B.identify_number) }
            When '前往當事人A的密碼重設頁' do
              before { visit(edit_party_password_path(reset_password_token: token)) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_profile_path)
                expect(page).to have_content('你僅能修改本人的帳號')
              end
            end
          end
        end

        Scenario '成功設定密碼後應自動登入' do
          let!(:party_A) { create :party, :already_confirmed }
          let!(:token) { party_A.set_reset_password_token }
          Given '當事人正在重設密碼頁，且已登入' do
            before { signin_party(identify_number: party_A.identify_number) }
            before { visit(edit_party_password_path(reset_password_token: token)) }
            When '送出新密碼' do
              before { edit_password('11111111') }
              Then '轉跳至當事人個人頁' do
                expect(current_path).to eq(party_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end

          Given '當事人正在重設密碼頁，且未登入' do
            before { visit(edit_party_password_path(reset_password_token: token)) }
            When '送出新密碼' do
              before { edit_password('11111111') }
              Then '轉跳至當事人個人頁' do
                expect(current_path).to eq(party_root_path)
                expect(page).to have_content('您的密碼已被修改，下次登入時請使用新密碼登入。')
              end
            end
          end
        end
      end
    end
  end
end
