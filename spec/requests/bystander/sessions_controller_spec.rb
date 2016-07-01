require 'rails_helper'

RSpec.describe Bystander::SessionsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#create" do
    context "success" do
      before { post "/bystander/sign_in", bystander: { email: bystander.email, password: "123123123" } }

      it { expect(bystander.reload.last_sign_in_at).to be_present }
      it { expect(response).to redirect_to("/bystander/profile") }
    end

    context "without validate email" do
      let!(:bystander_without_validate) { FactoryGirl.create :bystander_without_validate }
      before { post "/bystander/sign_in", bystander: { email: bystander_without_validate.email, password: bystander_without_validate.password } }

      it { expect(bystander_without_validate.reload.last_sign_in_at).to be_nil }
      it { expect(response).to redirect_to("/bystander/sign_in") }
    end

    context "root should not change" do
      before { signin_bystander }

      it { expect(get "/").to render_template("base/index") }
    end
  end

  describe "#destroy" do
    context "success" do
      before { signin_bystander }
      subject { delete "/bystander/sign_out" }

      it { expect(subject).to redirect_to("/bystander/sign_in") }
    end

    context "only sign out lawyer" do
      before { signin_bystander }
      before { signin_lawyer }
      subject! { delete "/bystander/sign_out" }

      it { expect(get "/lawyer/profile").to eq(200) }
      it { expect(get "/bystander/profile").to eq(302) }
    end
  end

end
