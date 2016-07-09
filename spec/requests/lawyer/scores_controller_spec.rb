require "rails_helper"

RSpec.describe Lawyer::ScoresController, type: :request do
  before { signin_lawyer }

  describe "#index" do
    subject! { get "/lawyer" }
    it { expect(response).to be_success }
  end

  describe "#show" do
    subject! { get "/lawyer/scores/xxxxx" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject! { get "/lawyer/scores/xxxx/edit" }
    it { expect(response).to be_success }
  end

  describe "#chose_type" do
    subject! { get "/lawyer/score/chose-type" }
    it { expect(response).to be_success }
  end
end
