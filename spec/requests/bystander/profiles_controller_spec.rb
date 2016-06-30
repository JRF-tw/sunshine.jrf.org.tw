require 'rails_helper'

RSpec.describe Bystander::ProfilesController, type: :request do
  before { signin_bystander }

  describe "#show" do
    subject!{ get "/bystander/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject!{ get "/bystander/profile/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    subject!{ put "/bystander/profile", bystander: { phone_number: "0922222222" } }
    it { expect(response).to redirect_to("/bystander/profile") }
  end
end
