require 'rails_helper'

RSpec.describe SuitsController, type: :request do
  let!(:suit) { create :suit }
  let!(:procedure) { create :procedure, suit: suit }

  it 'GET /suits' do
    get '/suits'
    expect(response).to be_success
  end

  it 'GET /suits/suit.id' do
    get "/suits/#{suit.id}"
    expect(response).to be_success
  end
end
