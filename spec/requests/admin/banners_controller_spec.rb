require "rails_helper"

RSpec.describe Admin::BannersController do
  before { signin_user }

  describe "already had a banner" do
    let(:banner) { create :banner }

    it "GET /admin/banners" do
      get "/admin/banners"
      expect(response).to be_success
    end

    it "GET /admin/banners/new" do
      get "/admin/banners/new"
      expect(response).to be_success
    end

    it "GET /admin/banners/123/edit" do
      get "/admin/banners/#{banner.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/banners/123" do
      expect {
        put "/admin/banners/#{banner.id}", admin_banner: { weight: 2 }
      }.to change { banner.reload.weight }.to(2)
      expect(response).to be_redirect
    end

    it "DELETE /admin/banners/123" do
      delete "/admin/banners/#{banner.id}"
      expect(Banner.count).to be_zero
    end
  end

  it "POST /admin/banners" do
    expect {
      post "/admin/banners", admin_banner: attributes_for(:banner)
    }.to change { Banner.count }.by(1)
    expect(response).to be_redirect
  end
end
