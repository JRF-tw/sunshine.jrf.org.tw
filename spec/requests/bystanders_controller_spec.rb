require 'rails_helper'

RSpec.describe BystandersController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#index" do
    context "render success" do
      before { get "/bystanders" }
      it { expect(response).to be_success }
    end
  end

  describe "#action" do

    context "sign in" do
      before { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "123123123" } }
      it { expect(bystander.reload.last_sign_in_at).to be_present }
    end

    context "sign up with exist e-mail" do
      subject { post "/bystanders", bystander: { name: "haha", email: bystander.email, password: "5566"} }
      it { expect{ subject }.to_not change{ Bystander.count } }
    end

    context "sign in without validate email" do
      let!(:bystander_without_validate) { FactoryGirl.create :bystander_without_validate }
      before { post "/bystanders/sign_in", bystander: { email: bystander_without_validate.email, password: bystander_without_validate.password } }

      it { expect(bystander_without_validate.reload.last_sign_in_at).to be_nil }
    end
  end

end
