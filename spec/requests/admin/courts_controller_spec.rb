require 'rails_helper'

RSpec.describe Admin::CourtsController do
  before{ signin_user }
  
  describe "#index" do
    let!(:court1) { FactoryGirl.create :court, court_type: "法院", full_name: "台北第一法院", name: "台北第一" }
    let!(:court2) { FactoryGirl.create :court, court_type: "檢察署", full_name: "台南第一法院", name: "台北第一" }

    context "search the type of courts" do
      before { get "/admin/courts", q: { court_type_eq: "法院" } }
      it {
        expect(response.body).to match(court1.full_name)
        expect(assigns(:courts).first.id).to eq court1.id
      }
    end  

    context "search the fullname of courts" do
      before { get "/admin/courts", q: { full_name_cont: "台南第一法院" } }
      it {
        expect(response.body).to match(court2.full_name)
        expect(assigns(:courts).first.id).to eq court2.id
      }
    end  
  end  

  describe "already had a court" do
    let!(:court) { FactoryGirl.create :court }

    it "GET /admin/courts" do
      get "/admin/courts"
      expect(response).to be_success
    end

    it "GET /admin/courts/new" do
      get "/admin/courts/new"
      expect(response).to be_success
    end

    it "GET /admin/courts/123/edit" do
      get "/admin/courts/#{court.id}/edit"
      expect(response).to be_success
    end
    
    context "#update" do
      subject { put "/admin/courts/#{court.id}", admin_court: { name: "haha" } }
      it { expect{ subject }.to change{ court.reload.name }.to("haha") }
      it { expect(response).to be_redirect }
    end

    context "delete" do
      it { expect{ delete "/admin/courts/#{court.id}" }.to change{ Court.count }.by(-1) }
    end   
  end
  
  describe "#create" do
    subject { post "/admin/courts", admin_court: FactoryGirl.attributes_for(:court) }
    it { expect{ subject }.to change{ Court.count }.by(1) }
    it { expect(response).to be_redirect }
  end
end
