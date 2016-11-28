require 'rails_helper'

feature '前台帳號功能', type: :feature, js: true do
  feature '當事人' do
    let!(:party_A) { create :party, :without_phone_number, :with_unconfirmed_phone }
    def edit_phone_number(phone_number)
      visit(new_party_phone_path)
      party_input_phone_number(phone_number)
      click_button '寄送驗證碼'
    end

    def verify_phone_number(verify_code, run_time = 1)
      visit(verify_party_phone_path)
      run_time.times do
        party_input_verify_code(verify_code)
        click_button '認證'
      end
    end
    feature '手機驗證流程' do
      Scenario '手機號碼不能跟別人重複，包含別人正在驗證中的' do
        before { signin_party(identify_number: party_A.identify_number) }
        Given '當事人B已完成手機號碼驗證' do
          let!(:party_B) { create :party, :already_confirmed }
          When '輸入和當事人B一樣的手機號碼' do
            before { edit_phone_number(party_B.phone_number) }
            Then '顯示錯誤訊息' do
              expect(current_path).to eq(party_phone_path)
              expect(page).to have_content('該手機號碼已註冊')
            end
          end
        end

        Given '當事人B註冊後第一次輸入手機號碼 0988888888 ，進行驗證中' do
          let!(:party_B) { create :party, unconfirmed_phone: '0988888888' }
          When '輸入 0988888888' do
            before { edit_phone_number('0988888888') }
            Then '顯示錯誤訊息' do
              expect(current_path).to eq(party_phone_path)
              expect(page).to have_content('該手機號碼正等待驗證中')
            end
          end
        end

        Given '當事人B註冊後已完成手機驗證，但又再更改新手機號碼為 0988888888 ，進行驗證中' do
          let!(:party_B) { create :party, :already_confirmed, unconfirmed_phone: '0988888888' }
          When '輸入 0988888888' do
            before { edit_phone_number('0988888888') }
            Then '顯示錯誤訊息' do
              expect(current_path).to eq(party_phone_path)
              expect(page).to have_content('該手機號碼正等待驗證中')
            end
          end
        end
      end

      Scenario '簡訊發送條件，五分鐘內只能發送 2 次簡訊' do
        before { signin_party(identify_number: party_A.identify_number) }
        Given '5 分鐘內已送出 2 次手機驗證簡訊' do
          before { party_A.sms_sent_count.incr(2) }
          When '輸入可通過的手機號碼' do
            before { edit_phone_number('0988888888') }
            Then '顯示錯誤訊息' do
              expect(current_path).to eq(party_phone_path)
              expect(page).to have_content('五分鐘內只能寄送兩次簡訊')
            end
          end

          When '第 6 分鐘輸入可通過手機號碼' do
            before { party_A.sms_sent_count.reset }
            before { edit_phone_number('0988888888') }
            Then '成功送出驗證碼簡訊' do
              expect(current_path).to eq(verify_party_phone_path)
              expect(page).to have_content('已寄出簡訊認證碼')
            end
          end
        end
      end

      Scenario '認證碼通過的條件' do
        before { signin_party(identify_number: party_A.identify_number) }
        before { party_A.phone_varify_code = '1111' }
        Given '已嘗試錯誤 1 次，並且時間在 60 分鐘內' do
          before { verify_phone_number('2222') }
          When '輸入正確的驗證碼' do
            before { verify_phone_number('1111') }
            Then '成功驗證' do
              expect(current_path).to eq(party_root_path)
              expect(page).to have_content('驗證成功')
            end
          end
        end

        Given '嘗試錯誤 3 次之後 輸入正確的驗證碼也會無效 ' do
          Then '同 request 測試' do
          end
        end

        Given '已超過 60 分鐘' do
          before { visit(verify_party_phone_path) }
          before { party_input_verify_code('2222') }
          before { party_A.update_attributes(unconfirmed_phone: nil) }
          before { party_A.phone_varify_code = nil }
          When '輸入正確的驗證碼' do
            before { click_button '認證' }
            Then '顯示錯誤訊息 並導向至手機輸入頁面' do
              expect(current_path).to eq(edit_party_phone_path)
              expect(page).to have_content('請先設定手機號碼')
            end
          end
        end
      end

      Scenario '未通過手機認證下，可以登入、但會被強制導到手機號碼輸入頁' do
        Given '尚未通過手機驗證' do
          before { party_A.unconfirmed_phone = '0988888888' }
          When '進行登入' do
            before { signin_party(identify_number: party_A.identify_number) }
            Then '導至手機號碼輸入頁' do
              expect(current_path).to eq(new_party_phone_path)
              expect(page).to have_content('成功登入了')
            end
          end
        end

        Given '尚未通過手機驗證，已登入' do
          before { signin_party(identify_number: party_A.identify_number) }
          When '前往評鑑記錄頁面' do
            before { visit(party_root_path) }
            Then '導至手機號碼輸入頁' do
              expect(current_path).to eq(new_party_phone_path)
            end
          end
        end
      end
    end
  end
end
