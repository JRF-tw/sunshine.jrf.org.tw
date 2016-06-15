require 'rails_helper'

RSpec.describe Admin::LawyersController do
  before{ signin_user }
  let!(:lawyer) {FactoryGirl.create :lawyer}

  describe "#index" do
    context "render success" do
      before { get "/admin/lawyers" }
      it { expect(response).to be_success }
    end
  end

  describe "#new" do
    context "render success" do
      before { get "/admin/lawyers/new" }
      it { expect(response).to be_success }
    end
  end

  describe "#edit" do
    context "render edit success" do
      before { get "/admin/lawyers/#{lawyer.id}/edit" }
      it { expect(response).to be_success }
    end
  end

  describe "#update" do
    context "update success" do
      subject { put "/admin/lawyers/#{lawyer.id}", admin_lawyer: { name: "阿里不打" } }
      it { expect{ subject }.to change { lawyer.reload.name }.to("阿里不打") }
      it { expect(response).to be_redirect }
    end
  end


  describe "#delete" do
    context "delete success" do
      subject { delete "/admin/lawyers/#{lawyer.id}" }
      it { expect{ subject }.to change { Lawyer.count }.by(-1) }
      it { expect(response).to be_redirect }
    end
  end

  describe "#create" do
    context "create success" do
      subject { post "/admin/lawyers", admin_lawyer: { name: "火焰巴拉", email: "aron@example.com" } }
      it { expect{ subject }.to change { Lawyer.count }.by(1) }
      it { expect(response).to be_redirect }
    end
  end

  describe "send_reset_password_mail" do
    context "success" do
      subject! { post "/admin/lawyers/#{lawyer.id}/send_reset_password_mail" }
      it { expect(response).to redirect_to("/admin/lawyers") }
    end
  end

end
