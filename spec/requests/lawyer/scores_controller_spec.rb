require 'rails_helper'

RSpec.describe Lawyer::ScoresController, type: :request do
  before { signin_lawyer }

  describe "#index" do
    subject!{ get "/lawyer/scores" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject!{ get "/lawyer/scores/xxxx/edit" }
    it { expect(response).to be_success }
  end
end
