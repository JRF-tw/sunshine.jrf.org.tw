require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    def edit_phone_number(phone_number)
      visit(edit_party_phone_path)
      party_input_phone_number(phone_number)
      click_button '送出'
    end

    def verify_phone_number(verify_code)
      visit(verify_party_phone_path)
      party_input_verify_code(verify_code)
      click_button '認證'
    end
    feature '更改手機號碼' do
      let!(:party_A) { create :party, :already_confirmed }
      before { signin_party(identify_number: party_A.identify_number) }
      feature '送出驗證碼' do
        Scenario '當事人A已登入，進行手機號碼更改。新手機號碼不能和其他人（包含自己）已驗證或驗證中的號碼相同' do
          let(:party_B) { create :party, :already_confirmed }
          Given '當事人A已通過手機驗證' do
            When '送出原本的手機號碼' do
              before { edit_phone_number(party_A.phone_number) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_phone_path)
                expect(page).to have_content('手機號碼不可與原本相同')
              end
            end

            When '送出符合格式的新手機號碼' do
              before { edit_phone_number('0922556556') }
              Then '導向驗證碼輸入頁面' do
                expect(current_path).to eq(verify_party_phone_path)
                expect(page).to have_content('已寄出簡訊認證碼')
              end
            end
          end

          Given '當事人A已通過手機驗證 待驗證中號碼為 0988888888' do
            before { party_A.unconfirmed_phone = '0988888888' }
            When '送出 0988888888' do
              before { edit_phone_number('0988888888') }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_phone_path)
                expect(page).to have_content('該手機號碼正等待驗證中')
              end
            end
          end

          Given '當事人B已通過手機驗證' do
            When '送出當事人B的手機號碼' do
              before { edit_phone_number(party_B.phone_number) }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_phone_path)
                expect(page).to have_content('該手機號碼已註冊')
              end
            end
          end

          Given '當事人B待驗證中手機號碼為 0988888888' do
            before { party_B.unconfirmed_phone = '0988888888' }
            When '送出 0988888888' do
              before { edit_phone_number('0988888888') }
              Then '顯示錯誤訊息' do
                expect(current_path).to eq(party_phone_path)
                expect(page).to have_content('該手機號碼正等待驗證中')
              end
            end
          end
        end

        Scenario '手機號碼輸入檢查條件情境同「手機驗證流程」' do
          it ' ' do
          end
        end
      end

      feature '輸入正確的驗證碼後，舊手機號碼被取代' do
        Scenario '輸入簡訊中驗證碼後，新手機號碼代換舊的手機號碼' do
          before { party_A.phone_varify_code.value = '1111' }
          before { party_A.unconfirmed_phone = '0956556556' }
          Given '送出新手機的驗證碼' do
            When '輸入正確的驗證碼' do
              before { verify_phone_number('1111') }
              Then '新手機號碼成功代換' do
                expect(current_path).to eq(party_root_path)
                expect(page).to have_content('已驗證成功')
              end
            end

            When '輸入錯誤的驗證碼' do
              before { verify_phone_number('55688') }
              Then '新手機號碼代換失敗' do
                expect(current_path).to eq(verifing_party_phone_path)
                expect(page).to have_content('驗證碼輸入錯誤')
              end
            end
          end
        end

        Scenario '驗證碼輸入檢查條件同「手機驗證流程」' do
          it ' ' do
          end
        end
      end
    end
  end
end
