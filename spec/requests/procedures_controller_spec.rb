require "rails_helper"

RSpec.describe ProceduresController, type: :request do
  let!(:suit) { create :suit }
  let!(:procedure) { create :procedure, suit: suit }

  it "GET /suits/suit.id/procedures" do
    get "/suits/#{suit.id}/procedures"
    expect(response).to be_success
  end
end
