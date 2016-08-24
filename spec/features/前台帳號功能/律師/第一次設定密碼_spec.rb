require "rails_helper"
feature "該律師為了完成註冊，第一次設定密碼", type: :feature, js: true do
  let!(:lawyer) { capybara_register_lawyer }
  let!(:reset_password_token) { lawyer.send_reset_password_instructions }

  feature "有律師登入的狀態下，就無法進入設定密碼頁" do
    Scenario "該律師已登入（已通過認證)" do
      Given "該律師已認證+登入" do
        before { capybara_setting_password_lawyer(lawyer, password: "00000000") }
        before { lawyer.confirm }
        before { capybara_signin_lawyer(lawyer, password: "00000000") }

        When "前往該律師的密碼設定頁" do
          before { visit(edit_lawyer_password_path(reset_password_token: reset_password_token)) }
          Then "頁面轉跳" do
            expect(current_path).to eq(lawyer_profile_path)
            expect(page).to have_content("無效的驗證連結")
          end
        end
      end
    end

    Scenario "已登入律師B" do
      Given "該律師已收到密碼設定信件, 且律師B已認證+登入" do
        let(:lawyer_b_data) { { name: "ABC", phone: 33_381_841, email: "aaabbbccc@hotmail.com" } }
        let!(:lawyer_b) { capybara_register_lawyer(lawyer_b_data) }
        before { capybara_setting_password_lawyer(lawyer_b, password: "11111111") }
        before { capybara_signin_lawyer(lawyer_b, password: "11111111") }

        When "前往該律師的密碼設定頁" do
          before { visit(edit_lawyer_password_path(reset_password_token: reset_password_token)) }

          Then "頁面轉跳" do
            expect(current_path).to eq(lawyer_profile_path)
            expect(page).to have_content("你僅能修改本人的帳號")
          end
        end
      end
    end
  end

  feature "密碼設定頁要顯示 律師姓名 和 Email" do
    Given "該律師已收到密碼設定信件" do
      When "前往該律師的密碼設定頁" do
        before { visit(edit_lawyer_password_path(reset_password_token: reset_password_token)) }

        Then "頁面成功讀取且顯示該 律師姓名 和 Email" do
          expect(current_path).to match(edit_lawyer_password_path)
          expect(page).to have_content(lawyer.email)
          expect(page).to have_content(lawyer.name)
        end
      end
    end
  end

  feature "完成密碼設定後，註冊狀態改為已認證" do
    Scenario "該律師尚未通過認證" do
      Given "該律師已收到密碼設定信件誒, 且前往密碼設定頁" do
        before { visit(edit_lawyer_password_path(reset_password_token: reset_password_token)) }
        When "正確輸入完密碼後送出" do
          before { capybara_submit_password_lawyer(password: "123123123") }
          Then "該律師註冊狀態改為已認證" do
            expect(current_path).to match(lawyer_root_path)
            expect(page).to have_content("您的密碼已被修改")
            expect(lawyer.reload.confirmed?).to be_truthy
          end
        end
      end
    end
  end

  feature "成功設定密碼，使用新密碼可登入" do
    Given "該律師完成了第一次密碼設定" do
      before { visit(edit_lawyer_password_path(reset_password_token: reset_password_token)) }
      before { capybara_submit_password_lawyer(password: "123123123") }
      before { manual_http_request(:delete, "/lawyer/sign_out") }

      When "使用新密碼登入" do
        before { capybara_signin_lawyer(lawyer, password: "123123123") }
        Then "登入成功" do
          expect(current_path).to match(lawyer_root_path)
          expect(page).to have_content("請更新完整資料")
          expect(page).to have_button("更新個人資訊")
        end
      end
    end
  end
end
