require "rails_helper"

RSpec.describe Observers::ConfirmationsController, type: :request do
  before { post "/observer", court_observer: { name: "Curry", email: "h2312@gmail.com", password: "55667788", password_confirmation: "55667788" }, policy_agreement: "1" }

  describe "observer confirm" do
    context "first confirm" do
      subject { get "/observer/confirmation", confirmation_token: CourtObserver.last.confirmation_token }

      it { expect(subject).to redirect_to("/observer") }
      it { expect { subject }.to change { CourtObserver.last.confirmed_at } }
    end

    context "change email confirm (feature spec 已測)" do
    end

    context "already confirmed" do
      before { get "/observer/confirmation", confirmation_token: CourtObserver.last.confirmation_token }
      subject { get "/observer/confirmation", confirmation_token: CourtObserver.last.confirmation_token }

      it { expect(subject).to redirect_to("/observer/sign_in") }
      it { expect { subject }.not_to change { CourtObserver.last.confirmed_at } }
    end

    context "invalidated confirm token" do
      before { get "/observer/confirmation", confirmation_token: "yayayaya" }
      it { expect(response).to redirect_to("/observer/sign_in") }
    end
  end

  describe "#new" do
    context "Resend confirmation page" do
      before { get "/observer/confirmation/new" }
      it { expect(response).to redirect_to("/observer/sign_in") }
    end
  end

  describe "#create" do
    context "success" do
      let!(:court_observer) { create :court_observer, :with_unconfirmed_email }
      subject { post "/observer/confirmation", court_observer: { email: court_observer.email } }

      it { expect(subject).to redirect_to("/observer/edit") }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
