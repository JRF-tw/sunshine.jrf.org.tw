require 'rails_helper'

RSpec.describe Bystander::RegistrationsController, :type => :request do

  describe "#update" do
    before { signin_bystander }
    let!(:bystander) { current_bystander }

    context "update email" do
      before { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      it { expect(response).to redirect_to("/bystanders")}
    end

    context "update same email" do
      before { put "/bystanders", bystander: { email: current_bystander.email, current_password: "123123123"} }
      it { expect(response.body).to match("e-mail 並未更改")}
    end

    context "sign in with unconfirmed_email" do
      before { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      before { signout_bystander }
      subject { post "/bystanders/sign_in", bystander: { email: "h2312@gmail.com", password: "123123123" } }

      it { expect{ subject }.to_not change {bystander.reload.last_sign_in_at} }
    end

    context "sign in with confirmed_email" do
      it "not done yet"
    end
  end

end
