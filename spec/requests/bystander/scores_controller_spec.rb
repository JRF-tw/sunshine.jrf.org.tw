require 'rails_helper'

RSpec.describe Bystander::ScoresController, type: :request do
  before { signin_bystander }

  describe "#index" do
    subject!{ get "/bystander/scores" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject!{ get "/bystander/scores/xxxx/edit" }
    it { expect(response).to be_success }
  end

  describe "#chose_type" do
    subject!{ get "/bystander/score/chose-type" }
    it { expect(response).to be_success }
  end
end
