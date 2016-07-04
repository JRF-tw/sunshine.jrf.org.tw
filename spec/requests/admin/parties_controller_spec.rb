require "rails_helper"

RSpec.describe Admin::PartiesController do
  before { signin_user }
  let!(:party) { FactoryGirl.create :party }

  describe "#index" do
    context "render success" do
      before { get "/admin/parties" }
      it { expect(response).to be_success }
    end

    context "search name" do
      before { get "/admin/parties", q: { name_cont: party.name } }
      it { expect(response.body).to match(party.phone_number) }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/parties/#{party.id}" }
      it { expect(response).to be_success }
    end
  end

  describe "#set_to_imposter" do
    context "success" do
      before { put "/admin/parties/#{party.id}/set_to_imposter" }
      it { expect(response).to redirect_to("/admin/parties") }
    end
  end
end
