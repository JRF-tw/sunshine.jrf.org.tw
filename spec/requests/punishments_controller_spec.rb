require 'rails_helper'

RSpec.describe PunishmentsController, :type => :request do
  let!(:profile){ FactoryGirl.create :profile }
  let!(:punishment){ FactoryGirl.create :punishment, profile: profile }
  
  it "GET /profiles/profile.id/punishments/punishment.id" do
    get "/profiles/#{profile.id}/punishments/#{punishment.id}"
    expect(response).to be_success
  end
end
