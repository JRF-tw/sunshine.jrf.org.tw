require "rails_helper"

RSpec.describe Admin::BaseController do
  it ".authenticate_user!" do
    get "/admin"
    expect(response).not_to be_success
  end

  context ".authenticate_admin_user!" do
    it "success" do
      signin_user(create(:admin_user))
      get "/admin"
      expect(response).to be_success
    end

    it "not admin" do
      signin_user(create(:user))
      get "/admin"
      expect(response).not_to be_success
    end
  end
end
