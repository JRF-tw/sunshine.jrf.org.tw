require "rails_helper"

feature "當事人可以訂閱以及取消電子報", type: :feature, js: true do
  let!(:party) { create :party, :already_confirmed }
  before { capybara_signin_party(party) }

  Scenario "進行訂閱" do
    Given "當事人尚未訂閱電子報" do
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(party_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「已訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("取消訂閱電子報")
        end
      end
    end
  end

  Scenario "取消訂閱" do
    Given "當事人已訂閱電子報" do
      before { party.update_attributes(subscribe_edm: true) }
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(party_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「未訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("訂閱電子報")
        end
      end
    end
  end

  Scenario "未通過 Email 認證狀態下進行訂閱" do
    Given "當事人正在進行 Email 認證中" do
      before { party.update_attributes(confirmed_at: nil) }

      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(party_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "訂閱失敗" do
          expect(find(".js-subscribe-edm")).to have_content("尚未驗證Email")
        end
      end
    end
  end

  Scenario "未填寫 Email 狀態下進行訂閱" do
    Given "當事人的 Email 欄位未填寫" do
      before { party.update_attributes(email: "") }

      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(party_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "訂閱失敗" do
          expect(find(".js-subscribe-edm")).to have_content("Email未填寫")
        end
      end
    end
  end
end
