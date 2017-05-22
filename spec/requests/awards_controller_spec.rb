require 'rails_helper'

RSpec.describe AwardsController, type: :request do
  let!(:judge) { create :judge }
  let!(:award) { create :award, owner: judge }

  it 'GET /judges/judge.id/awards' do
    get "/judges/#{judge.id}/awards"
    expect(response).to be_success
  end
end
