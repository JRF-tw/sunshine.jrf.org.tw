require 'rails_helper'

RSpec.describe Admin::LicensesController do
  let!(:profile) { FactoryGirl.create :profile }

  before { signin_user }

  describe "already had a license" do
    let!(:license) { FactoryGirl.create :license, profile: profile }

    it "GET /admin/profiles/profile.id/licenses" do
      get "/admin/profiles/#{profile.id}/licenses"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/licenses/new" do
      get "/admin/profiles/#{profile.id}/licenses/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/licenses/123/edit" do
      get "/admin/profiles/#{profile.id}/licenses/#{license.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/profile.id/licenses/123" do
      expect {
        put "/admin/profiles/#{profile.id}/licenses/#{license.id}", admin_license: { license_type: "keke" }
      }.to change { license.reload.license_type }.to("keke")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/profile.id/licenses/123" do
      delete "/admin/profiles/#{profile.id}/licenses/#{license.id}"
      expect(License.count).to be_zero
    end
  end

  it "POST /admin/profiles/profile.id/licenses" do
    expect {
      post "/admin/profiles/#{profile.id}/licenses", admin_license: FactoryGirl.attributes_for(:license)
    }.to change { License.count }.by(1)
    expect(response).to be_redirect
  end
end
