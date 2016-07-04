require "rails_helper"

RSpec.describe Admin::PunishmentsController do
  let!(:profile) { FactoryGirl.create :profile }

  before { signin_user }

  describe "already had a punishment" do
    let!(:punishment) { FactoryGirl.create :punishment, profile: profile }

    it "GET /admin/profiles/profile.id/punishments" do
      get "/admin/profiles/#{profile.id}/punishments"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/punishments/new" do
      get "/admin/profiles/#{profile.id}/punishments/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/punishments/123/edit" do
      get "/admin/profiles/#{profile.id}/punishments/#{punishment.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/profile.id/punishments/123" do
      expect {
        put "/admin/profiles/#{profile.id}/punishments/#{punishment.id}", admin_punishment: { punish_type: "haha" }
      }.to change { punishment.reload.punish_type }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/profile.id/punishments/123" do
      delete "/admin/profiles/#{profile.id}/punishments/#{punishment.id}"
      expect(Punishment.count).to be_zero
    end
  end

  it "POST /admin/profiles/profile.id/punishments" do
    expect {
      post "/admin/profiles/#{profile.id}/punishments", admin_punishment: FactoryGirl.attributes_for(:punishment)
    }.to change { Punishment.count }.by(1)
    expect(response).to be_redirect
  end
end
