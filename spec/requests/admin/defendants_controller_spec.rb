require 'rails_helper'

RSpec.describe Admin::DefendantsController do
  before{ signin_user }
  let!(:defendant) { FactoryGirl.create :defendant }

  describe "#index" do
    context "render success" do
      before { get "/admin/defendants" }
      it { expect(response).to be_success }
    end

    context "search name" do
      before { get "/admin/defendants", q: { name_cont: defendant.name } }
      it { expect(response.body).to match(defendant.phone_number) }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/defendants/#{defendant.id}" }
      it { expect(response).to be_success }
    end
  end
end
