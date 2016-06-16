require 'rails_helper'

RSpec.describe Bystanders::PasswordsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander }
  let(:token) { bystander.send_reset_password_instructions }

  describe "#update" do
    context "success" do
      before { put "/bystanders/password", bystander: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }
      subject { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "55667788" } }

      it { expect(response).to redirect_to("/bystanders") }
      it "sign in with updated password" do 
        signout_bystander 
        expect { subject }.to change{ bystander.reload.current_sign_in_at }
      end
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_bystander }
    subject! { post "/bystanders/password/send_reset_password_mail" }

    it { expect(response).to redirect_to("/bystanders/profile") }
  end


end
