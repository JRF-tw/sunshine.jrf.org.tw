require 'rails_helper'

RSpec.describe Admin::ProfilesController do
  before{ signin_user }

  describe "already had a profile" do
    let(:profile){ FactoryGirl.create :profile }

    it "GET /admin/profiles" do
      get "/admin/profiles"
      expect(response).to be_success
    end

    it "GET /admin/profiles/new" do
      get "/admin/profiles/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/123/edit" do
      get "/admin/profiles/#{profile.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/123" do
      expect{
        put "/admin/profiles/#{profile.id}", admin_profile: { name: "haha" }
      }.to change{ profile.reload.name }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/123" do
      delete "/admin/profiles/#{profile.id}"
      expect(Profile.count).to be_zero
    end
  end

  it "POST /admin/profiles" do
    expect{
      post "/admin/profiles", admin_profile: FactoryGirl.attributes_for(:profile)
    }.to change{ Profile.count }.by(1)
    expect(response).to be_redirect
  end
end
