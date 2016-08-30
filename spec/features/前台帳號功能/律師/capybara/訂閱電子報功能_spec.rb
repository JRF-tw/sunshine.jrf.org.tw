require "rails_helper"

feature "律師可以訂閱以及取消電子報", type: :feature, js: true do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  before { capybara_signin_lawyer(lawyer, password: lawyer.password) }

  Scenario "進行訂閱" do
    Given "律師尚未訂閱電子報" do
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(lawyer_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「已訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("取消訂閱電子報")
        end
      end
    end
  end

  Scenario "取消訂閱" do
    Given "律師已訂閱電子報" do
      before { lawyer.update_attributes(subscribe_edm: true) }
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(lawyer_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「未訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("訂閱電子報")
        end
      end
    end
  end
end
