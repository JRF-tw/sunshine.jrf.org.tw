require 'rails_helper'

RSpec.describe Admin::JudgesController do
  before{ signin_user }
  let!(:judge) {FactoryGirl.create :judge}

  describe "#index" do
    context "render success" do
      before { get "/admin/judges" }
      it { expect(response).to be_success }
    end

   context "search the court of judge" do
      before { get "/admin/judges", q: { current_court_id_eq: judge.current_court_id} }
      it { expect(response.body).to match(judge.name) }
    end
  end  

  describe "#new" do
    context "render success" do
      before { get "/admin/judges/new" }
      it { expect(response).to be_success }
    end
  end  

  describe "#edit" do
    context "render edit success" do
      before { get "/admin/judges/#{judge.id}/edit" }
      it { expect(response).to be_success }
    end
  end  

  describe "#update" do
    context "update success" do
      subject { put "/admin/judges/#{judge.id}", admin_judge: { name: "哭哭" } }
      it { expect{ subject }.to change { judge.reload.name }.to("哭哭") }
      it { expect(response).to be_redirect }
    end
  end


  describe "#delete" do
    context "delete success" do
      subject { delete "/admin/judges/#{judge.id}" }
      it { expect{ subject }.to change { Judge.count }.by(-1) }
      it { expect(response).to be_redirect }
    end
  end  

  describe "#create" do
    context "delete success" do
      subject { post "/admin/judges", admin_judge: { name: "笑笑" } }
      it { expect{ subject }.to change { Judge.count }.by(1) }
      it { expect(response).to be_redirect }
    end
  end


end
