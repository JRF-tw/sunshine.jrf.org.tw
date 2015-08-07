require 'rails_helper'

RSpec.describe Admin::CourtsController do
  before{ signin_user }

  describe "already had a court" do
    let(:court){ FactoryGirl.create :court }

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

    it "PUT /admin/courts/123" do
      expect{
        put "/admin/courts/#{court.id}", admin_court: { name: "haha" }
      }.to change{ court.reload.name }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/courts/123" do
      delete "/admin/courts/#{court.id}"
      expect(Court.count).to be_zero
    end
  end

  it "POST /admin/courts" do
    expect{
      post "/admin/courts", admin_court: FactoryGirl.attributes_for(:court)
    }.to change{ Court.count }.by(1)
    expect(response).to be_redirect
  end
end
