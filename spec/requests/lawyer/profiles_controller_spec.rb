require 'rails_helper'

RSpec.describe Lawyer::ProfilesController, type: :request do
  before { signin_lawyer }

  describe "#show" do
    subject! { get "/lawyer/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject! { get "/lawyer/profile/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    subject! { put "/lawyer/profile", lawyer: { current: "律師事務所" } }
    it { expect(response).to redirect_to("/lawyer/profile") }
  end
end
