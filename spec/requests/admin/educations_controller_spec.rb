require "rails_helper"

RSpec.describe Admin::EducationsController do
  let!(:profile) { create :profile }

  before { signin_user }

  describe "already had a education" do
    let!(:education) { create :education, profile: profile }

    it "GET /admin/profiles/profile.id/educations" do
      get "/admin/profiles/#{profile.id}/educations"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/educations/new" do
      get "/admin/profiles/#{profile.id}/educations/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/educations/123/edit" do
      get "/admin/profiles/#{profile.id}/educations/#{education.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/profile.id/educations/123" do
      expect {
        put "/admin/profiles/#{profile.id}/educations/#{education.id}", admin_education: { title: "haha" }
      }.to change { education.reload.title }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/profile.id/educations/123" do
      delete "/admin/profiles/#{profile.id}/educations/#{education.id}"
      expect(Education.count).to be_zero
    end
  end

  it "POST /admin/profiles/profile.id/educations" do
    expect {
      post "/admin/profiles/#{profile.id}/educations", admin_education: attributes_for(:education)
    }.to change { Education.count }.by(1)
    expect(response).to be_redirect
  end
end
