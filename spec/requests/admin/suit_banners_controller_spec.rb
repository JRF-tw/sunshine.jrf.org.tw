require "rails_helper"

RSpec.describe Admin::SuitBannersController do
  before { signin_user }

  describe "already had a suit_banner" do
    let(:suit_banner) { FactoryGirl.create :suit_banner }

    it "GET /admin/suit_banners" do
      get "/admin/suit_banners"
      expect(response).to be_success
    end

    it "GET /admin/suit_banners/new" do
      get "/admin/suit_banners/new"
      expect(response).to be_success
    end

    it "GET /admin/suit_banners/123/edit" do
      get "/admin/suit_banners/#{suit_banner.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/suit_banners/123" do
      expect {
        put "/admin/suit_banners/#{suit_banner.id}", admin_suit_banner: { weight: 2 }
      }.to change { suit_banner.reload.weight }.to(2)
      expect(response).to be_redirect
    end

    it "DELETE /admin/suit_banners/123" do
      delete "/admin/suit_banners/#{suit_banner.id}"
      expect(SuitBanner.count).to be_zero
    end
  end

  it "POST /admin/suit_banners" do
    expect {
      post "/admin/suit_banners", admin_suit_banner: FactoryGirl.attributes_for(:suit_banner)
    }.to change { SuitBanner.count }.by(1)
    expect(response).to be_redirect
  end
end
