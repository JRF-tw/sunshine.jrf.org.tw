require 'rails_helper'

RSpec.describe Bystander::SessionsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  context "#create" do
    before { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "123123123" } }
    it { expect(response).to redirect_to("/bystanders") }
  end


  describe "bystander action" do
    context "sign in" do
      before { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "123123123" } }
      it { expect(bystander.reload.last_sign_in_at).to be_present }
    end

    context "sign in without validate email" do
      let!(:bystander_without_validate) { FactoryGirl.create :bystander_without_validate }
      before { post "/bystanders/sign_in", bystander: { email: bystander_without_validate.email, password: bystander_without_validate.password } }

      it { expect(bystander_without_validate.reload.last_sign_in_at).to be_nil }
    end 

    context "sign out" do
      before { signin_bystander }
      subject { delete "/bystanders/sign_out", {}, {'HTTP_REFERER' => 'http://www.example.com/bystanders'}}
      
      it { expect(subject).to redirect_to("/bystanders") }
    end
  end

end
