require "rails_helper"

feature "觀察者可以訂閱以及取消電子報", type: :feature, js: true do
  let!(:court_observer) { create :court_observer }
  before { visit(new_court_observer_session_path) }
  before { capybara_input_sign_in_observer(email: court_observer.email, password: court_observer.password) }
  before { capybara_sign_in_observer }

  Scenario "進行訂閱" do
    Given "觀察者尚未訂閱電子報" do
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(court_observer_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「已訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("取消訂閱電子報")
        end
      end
    end
  end

  Scenario "取消訂閱" do
    Given "觀察者已訂閱電子報" do
      before { court_observer.update_attributes(subscribe_edm: true) }
      When "在個人資訊頁點擊電子報按鈕" do
        before { visit(court_observer_profile_path) }
        before { find(".js-subscribe-edm").find("a").click }

        Then "電子報狀態為「未訂閱」" do
          expect(find(".js-subscribe-edm")).to have_link("訂閱電子報")
        end
      end
    end
  end
end
