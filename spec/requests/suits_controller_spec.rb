require "rails_helper"

RSpec.describe SuitsController, type: :request do
  let!(:suit) { FactoryGirl.create :suit }
  let!(:procedure) { FactoryGirl.create :procedure, suit: suit }

  it "GET /suits" do
    get "/suits"
    expect(response).to be_success
  end

  it "GET /suits/suit.id" do
    get "/suits/#{suit.id}"
    expect(response).to be_success
  end
end
