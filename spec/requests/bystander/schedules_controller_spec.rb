require 'rails_helper'

RSpec.describe Bystander::SchedulesController, type: :request do

  before { signin_bystander }

  describe "#new" do
    subject! { get "/bystander/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/bystander/score/schedules/verify" }
    it { expect(response).to be_redirect }
  end
end
