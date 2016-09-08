require "rails_helper"

describe Lawyer::RegisterContext do
  let!(:lawyer) { create :lawyer }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_setting_password_mail) }
    end

    context "without policy agreement" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }) }
      it { expect { subject.perform }.to change { subject.errors[:without_policy_agreement] } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_setting_password_mail) }
    end

    context "invalid email" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: "gg33" }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:email_invalid] } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "empty email" do
      subject { described_class.new(lawyer: { name: lawyer.name }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:email_blank] } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "empty name" do
      subject { described_class.new(lawyer: { email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:name_blank] } }
    end

    context "lawyer not found" do
      subject { described_class.new(lawyer: { name: "阿英阿紅", email: "a@example.com" }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_not_found_manual_sign_up] } }
    end

    context "lawyer already confirmed" do
      before { lawyer.confirm }
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_exist_please_sign_in] } }
    end

    context "generate reset password token" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { [lawyer.reload.reset_password_token, lawyer.reload.reset_password_sent_at] } }
    end
  end

end
