require 'rails_helper'

RSpec.describe BystandersController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#index" do
    context "render success" do
      before { get "/bystanders" }
      it { expect(response).to be_success }
    end
  end

end
