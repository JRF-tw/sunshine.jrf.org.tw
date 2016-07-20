require "rails_helper"

RSpec.describe Admin::ProfilesController do
  before { signin_user }

  describe "already had a profile" do
    let!(:profile) { create :profile, name: "Dahlia", current: "法官" }

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
      expect {
        put "/admin/profiles/#{profile.id}", admin_profile: { name: "haha" }
      }.to change { profile.reload.name }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/123" do
      delete "/admin/profiles/#{profile.id}"
      expect(Profile.count).to be_zero
    end

    context "ransack" do
      let!(:hidden_profile) { create :profile, name: "Mars", current: "檢察官", is_hidden: true }
      let!(:unactive_profile) { create :profile, name: "Billy", current: "檢察官", is_active: false }
      it "is_active_true" do
        get "/admin/profiles", q: { is_active_true: true }
        expect(response.body).not_to match(unactive_profile.name)
      end

      it "is_hidden_true" do
        get "/admin/profiles", q: { is_hidden_true: true }
        expect(response.body).to match(hidden_profile.name)
      end

      it "name_cont" do
        get "/admin/profiles", q: { name_cont: "Da" }
        expect(response.body).to match(profile.name)
      end

      it "current_eq" do
        get "/admin/profiles", q: { current_eq: "法官" }
        expect(response.body).to match(profile.name)
        expect(response.body).not_to match(unactive_profile.name)
        expect(response.body).not_to match(hidden_profile.name)
      end
    end
  end

  it "POST /admin/profiles" do
    expect {
      post "/admin/profiles", admin_profile: FactoryGirl.attributes_for(:profile)
    }.to change { Profile.count }.by(1)
    expect(response).to be_redirect
  end
end
