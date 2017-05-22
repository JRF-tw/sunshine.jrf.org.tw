require 'rails_helper'

RSpec.describe PunishmentsController, type: :request do
  let!(:judge) { create :judge }
  let!(:punishment) { create :punishment, owner: judge }

  it 'GET /judges/judge.id/punishments' do
    get "/judges/#{judge.id}/punishments"
    expect(response).to be_success
  end

  it 'GET /judges/judge.id/punishments/punishment.id' do
    get "/judges/#{judge.id}/punishments/#{punishment.id}"
    expect(response).to be_success
  end
end
