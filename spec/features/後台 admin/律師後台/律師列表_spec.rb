require 'rails_helper'

feature '後台系統', type: :feature, js: true do
  feature '律師後台' do
    before { admin_signin_user }
    feature '律師列表' do
      Scenario '能夠依註冊狀態搜尋律師，並且可知道結果總數' do
        Given '有未註冊律師和已註冊律師各一名' do
          let!(:lawyer_A) { create :lawyer, :with_confirmed, :with_password }
          let!(:lawyer_B) { create :lawyer }

          When '未下任何條件進入列表頁' do
            before { visit(admin_lawyers_path) }
            Then '顯示所有律師' do
              expect(page).to have_content(lawyer_A.name)
              expect(page).to have_content(lawyer_B.name)
            end
          end

          When '搜尋未註冊律師' do
            before { admin_search_lawyer(status: '未註冊') }
            Then '僅顯示未註冊律師' do
              expect(page).not_to have_content(lawyer_A.name)
              expect(page).to have_content(lawyer_B.name)
            end
          end

          When '搜尋已註冊律師' do
            before { admin_search_lawyer(status: '已註冊') }
            Then '僅顯示已註冊律師' do
              expect(page).to have_content(lawyer_A.name)
              expect(page).not_to have_content(lawyer_B.name)
            end
          end
        end
      end
    end

    feature '新增律師' do
      def create_lawyer(name, email)
        visit(new_admin_lawyer_path)
        admin_lawyer_input_create(name, email)
        click_button '送出'
      end
      Scenario '律師成功建立後，不會發送任何信件出去' do
        Given '登入後台並至律師新增頁' do
          When '填完律師新增表單，送出' do
            before { create_lawyer('我愛羅', 'hhww2@hotmail.com') }
            Then '不會發送註冊信，也不會發送密碼設定信' do
              expect(fetch_sidekiq_last_job).to eq(nil)
            end
          end
        end
      end

      Scenario '無法建立重複的 Email' do
        Given '已有一名律師A已建立' do
          let!(:lawyer_A) { create :lawyer }
          When '送出和律師A相同Email的表單' do
            before { create_lawyer('我愛羅', lawyer_A.email) }
            Then '建立失敗' do
              expect(current_path).to eq('/admin/lawyers')
              expect(page).to have_content('Email 已經被使用')
            end
          end
        end
      end
    end
  end
end
