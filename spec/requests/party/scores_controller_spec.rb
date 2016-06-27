require 'rails_helper'

RSpec.describe Party::ScoresController, type: :request do
  before { signin_party }

  describe "#index" do
    subject!{ get "/party/scores" }
    it { expect(response).to be_success }
  end
end
