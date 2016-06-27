require 'rails_helper'

RSpec.describe Party::ProfilesController, type: :request do
  before { signin_party }

  describe "#show" do
    subject!{ get "/party/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject!{ get "/party/profile/edit" }
    it { expect(response).to be_success }
  end
end
