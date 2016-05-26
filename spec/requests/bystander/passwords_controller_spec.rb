require 'rails_helper'

RSpec.describe Bystander::PasswordsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander, reset_password_token: "love_peace" }

  describe "bystander action" do
    context "update password" do
      before { find_reset_password_token_by_Bystander }
      before { put "/bystanders/password", bystander: { password: "55667788", password_confirmation: "55667788", reset_password_token: @reset_password_token } }
      subject { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "55667788" } }

      it { expect(response).to redirect_to("/bystanders") }
      it "sign in with updated password" do 
        signout_bystander 
        expect { subject }.to change{ bystander.reload.current_sign_in_at }
      end
    end
  end


end
