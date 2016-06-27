require 'rails_helper'

RSpec.describe Bystander::ScoresController, type: :request do
  before { signin_bystander }

  describe "#index" do
    subject!{ get "/bystander/scores" }
    it { expect(response).to be_success }
  end
end
