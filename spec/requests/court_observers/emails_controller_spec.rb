require "rails_helper"

RSpec.describe CourtObservers::EmailsController, type: :request do
  let(:observer) { create :court_observer, :with_unconfirmed_email, :with_confirmation_token }
  before { signin_court_observer(observer) }

  describe "#edit" do
    subject! { get "/observer/email/edit" }
    it { expect(response).to be_success }
  end

  describe "#resend_confirmation_mail" do
    subject { post "/observer/email/resend_confirmation_mail" }

    it { expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :resend_confirmation_instructions) }
  end
end
