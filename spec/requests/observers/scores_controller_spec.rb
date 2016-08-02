require "rails_helper"

RSpec.describe Observers::ScoresController, type: :request do
  before { signin_court_observer }

  describe "#index" do
    subject! { get "/observer" }
    it { expect(response).to be_success }
  end

  describe "#show" do
    subject! { get "/observer/scores/xxxxx" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject! { get "/observer/scores/xxxx/edit" }
    it { expect(response).to be_success }
  end

  describe "#chose_type" do
    subject! { get "/observer/score/chose-type" }
    it { expect(response).to be_success }
  end
end
