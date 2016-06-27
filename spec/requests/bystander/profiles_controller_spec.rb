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
end
