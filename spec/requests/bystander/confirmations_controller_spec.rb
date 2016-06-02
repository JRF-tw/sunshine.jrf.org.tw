require 'rails_helper'

RSpec.describe Bystander::ConfirmationsController, :type => :request do
  before { post "/bystanders", bystander: { name: "Curry", email: "h2312@gmail.com", password: "55667788", password_confirmation: "55667788"} }

  describe "bystander confirm" do
    context "first confirm" do
      subject { get "/bystanders/confirmation", confirmation_token: Bystander.last.confirmation_token }

      it { expect(subject).to redirect_to("/bystanders/sign_in") }
    end

    context "already confirmed" do
      before { get "/bystanders/confirmation", confirmation_token: Bystander.last.confirmation_token }
      subject { get "/bystanders/confirmation", confirmation_token: Bystander.last.confirmation_token }
      
      it {
        expect(subject).to redirect_to("/bystanders/sign_in")
        expect(flash[:notice]).to be_present
      }
    end
 
    context "invalidated confirm token" do
      before { get "/bystanders/confirmation", confirmation_token: "yayayaya" }
      it { expect(response).to redirect_to("/bystanders/sign_in") }
    end  
  end

  describe "#new" do
    context "Resend confirmation page" do
      before { get "/bystanders/confirmation/new" }
      it { expect(response).to redirect_to("/bystanders/sign_in") }
    end
  end

end
