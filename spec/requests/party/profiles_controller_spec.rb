require "rails_helper"

RSpec.describe Party::ProfilesController, type: :request do
  before { signin_party }

  describe "#show" do
    subject! { get "/party/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject! { get "/party/profile/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    subject! { put "/party/profile", party: { name: "律師事務所" } }
    it { expect(response).to redirect_to("/party/profile") }
  end
end
