require 'rails_helper'

RSpec.describe Bystanders::BaseController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#index" do

    context "log in" do
      before { signin_bystander }
      subject! { get "/bystanders" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/bystanders" }
      it { expect(response).to be_redirect }
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_bystander }
    subject! { post "/bystanders/send_reset_password_mail" }

    it { expect(response).to redirect_to("/bystanders/profile") }
  end

end
