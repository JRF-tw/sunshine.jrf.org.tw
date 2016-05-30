require 'rails_helper'

RSpec.describe Bystander::ConfirmationsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "bystander confirm" do
    context "first confirm" do
      let!(:bystander_without_validate) { FactoryGirl.create :bystander_without_validate }
      subject { get "/bystanders/confirmation", confirmation_token: bystander_without_validate.confirmation_token }

      it { expect(subject).to redirect_to("/bystanders/sign_in") }
    end

    context "already confirmed" do
      before { get "/bystanders/confirmation", confirmation_token: bystander.confirmation_token }
      it { expect(response).to redirect_to("/bystanders/sign_in") }
      it { expect(flash[:notice]).to be_present }
    end

    context "invalidated confirm token" do
      before { get "/bystanders/confirmation", confirmation_token: "yayayaya" }
      it { expect(response).to redirect_to("/bystanders/sign_in") }
    end  
  end

end
