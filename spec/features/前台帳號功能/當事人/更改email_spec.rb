require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    def party_click_confirm_link(email)
      open_last_email(email)
      current_email.find('a').click
    end

    def edit_email(email)
      visit(edit_party_email_path)
      party_input_edit_email(email: email)
      click_button '送出'
    end

    def sign_out_after_edit_email(party, email:)
      signin_party(identify_number: party.identify_number)
      edit_email(email)
      manual_http_request(:delete, '/party/sign_out')
    end

    feature '更改 Email' do
      let!(:party_A) { create :party, :already_confirmed, :with_confirmation_token }
      let!(:party_B) { create :party, :already_confirmed, :with_confirmation_token }
      feature '送出新 Email 認證' do
        Scenario '當事人A已登入，且新 Email 不能和任何人（包含自己）已認證的 Email 一樣' do
          before { signin_party(identify_number: party_A.identify_number) }
          Given '當事人B已完成 Email 認證' do
            When '當事人A的新 Email 和律師B一樣' do
              before { edit_email(party_B.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_email_path)
                expect(page).to have_content('email 已被使用')
              end
            end
          end

          Given '當事人B正在認證 Email `xx@xx.com`' do
            let!(:party_B) { create :party, :already_confirmed, :with_unconfirmed_email }
            When '新 Email 為 `xx@xx.com`' do
              before { edit_email(party_B.unconfirmed_email) }
              Then '送出新 Email 認證信' do
                expect(current_path).to eq(party_profile_path)
                expect(page).to have_content('需要重新驗證新的Email')
              end
            end
          end

          Given '當事人A的已認證 Email 為 `xx@xx.com`' do
            When '新 Email 為 `xx@xx.com`' do
              before { edit_email(party_A.email) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_email_path)
                expect(page).to have_content('email 不可與原本相同')
              end
            end
          end
        end
      end

      feature '點擊連結後，新 Email 代換舊 Email' do
        Scenario '若當事人A和B皆送出相同的 Email 認證，先點擊連結者可順利完成代換，其他相同 Email 者則不行' do
          Given '當事人A和當事人B送出相同的 Email 進行認證，且 B 已前往認證連結完成代換' do
            before { party_A.update_attributes(unconfirmed_email: 'test@gmail.com') }
            before { CustomDeviseMailer.delay.resend_confirmation_instructions(party_A) }
            let!(:party_B) { create :party, :already_confirmed, email: 'test@gmail.com' }
            When '當事人A前往認證連結' do
              before { party_click_confirm_link(party_A.reload.unconfirmed_email) }
              Then '當事人A的 Email 代換失敗' do
                expect(current_path).to eq(new_party_session_path)
                expect(page).to have_content('您的待驗證email已從別的帳號完成驗證')
              end
            end
          end
        end

        Scenario '無論是否登入或登入者為別人，認證連結均有效。當事人A 已送出 Email 進行認證。' do
          before { sign_out_after_edit_email(party_A, email: '4545@gmail.com') }
          Given '無當事人登入' do
            When '前往 Email 認證連結' do
              before { party_click_confirm_link(party_A.reload.unconfirmed_email) }
              Then '當事人A的 Email 認證成功' do
                expect(current_path).to eq(new_party_session_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '當事人A已登入' do
            before { signin_party(identify_number: party_A.identify_number) }
            When '前往 Email 認證連結' do
              before { party_click_confirm_link(party_A.reload.unconfirmed_email) }
              Then '當事人A的 Email 認證成功' do
                expect(current_path).to eq(party_profile_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end

          Given '當事人B已登入' do
            before { signin_party(identify_number: party_B.identify_number) }
            When '前往 Email 認證連結' do
              before { party_click_confirm_link(party_A.reload.unconfirmed_email) }
              Then '當事人A的 Email 認證成功' do
                expect(current_path).to eq(party_profile_path)
                expect(page).to have_content('您的帳號已通過驗證')
              end
            end
          end
        end
      end
    end
  end
end
