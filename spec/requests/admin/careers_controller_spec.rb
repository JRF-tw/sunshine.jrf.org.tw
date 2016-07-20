require "rails_helper"

RSpec.describe Admin::CareersController do
  let!(:profile) { create :profile }

  before { signin_user }

  describe "already had a career" do
    let!(:career) { create :career, profile: profile }

    it "GET /admin/profiles/profile.id/careers" do
      get "/admin/profiles/#{profile.id}/careers"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/careers/new" do
      get "/admin/profiles/#{profile.id}/careers/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/careers/123/edit" do
      get "/admin/profiles/#{profile.id}/careers/#{career.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/profile.id/careers/123" do
      expect {
        put "/admin/profiles/#{profile.id}/careers/#{career.id}", admin_career: { career_type: "haha" }
      }.to change { career.reload.career_type }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/profile.id/careers/123" do
      delete "/admin/profiles/#{profile.id}/careers/#{career.id}"
      expect(Career.count).to be_zero
    end
  end

  it "POST /admin/profiles/profile.id/careers" do
    expect {
      post "/admin/profiles/#{profile.id}/careers", admin_career: FactoryGirl.attributes_for(:career)
    }.to change { Career.count }.by(1)
    expect(response).to be_redirect
  end
end
