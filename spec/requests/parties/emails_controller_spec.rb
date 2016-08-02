require "rails_helper"

RSpec.describe Parties::EmailsController, type: :request do
  before { signin_party }

  describe "#edit" do
    subject! { get "/party/email/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    context "success" do
      subject { put "/party/email", party: { email: "5566@gmail.com", current_password: "12321313213" } }

      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
      it { expect(subject).to redirect_to("/party/profile") }
    end

    context "wrong password" do
      subject! { put "/party/email", party: { email: "5566@gmail.com", current_password: "" } }

      it { expect(current_party.email).not_to eq("5566@gmail.com") }
      it { expect(response.body).not_to match("目前等待驗證中信箱") }
    end
  end
end
