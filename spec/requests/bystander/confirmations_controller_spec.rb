require 'rails_helper'

RSpec.describe Bystander::ConfirmationsController, :type => :request do
  before { post "/bystander", bystander: { name: "Curry", email: "h2312@gmail.com", password: "55667788", password_confirmation: "55667788"} }

  describe "bystander confirm" do
    context "first confirm" do
      subject { get "/bystander/confirmation", confirmation_token: Bystander.last.confirmation_token }

      it { expect(subject).to redirect_to("/bystander/sign_in") }
      it { expect { subject }.to change { Bystander.last.confirmed_at } }
    end

    context "already confirmed" do
      before { get "/bystander/confirmation", confirmation_token: Bystander.last.confirmation_token }
      subject { get "/bystander/confirmation", confirmation_token: Bystander.last.confirmation_token }

      it { expect(subject).to redirect_to("/bystander/sign_in") }
      it { expect { subject }.not_to change { Bystander.last.confirmed_at } }
    end

    context "invalidated confirm token" do
      before { get "/bystander/confirmation", confirmation_token: "yayayaya" }
      it { expect(response).to redirect_to("/bystander/sign_in") }
    end
  end

  describe "#new" do
    context "Resend confirmation page" do
      before { get "/bystander/confirmation/new" }
      it { expect(response).to redirect_to("/bystander/sign_in") }
    end
  end

  describe "#create" do
    context "success" do
      let!(:bystander) { FactoryGirl.create :bystander, :with_unconfirmed_email}
      subject { post "/bystander/confirmation", bystander: { email: bystander.email } }

      it { expect(subject).to redirect_to("/bystander/edit") }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
