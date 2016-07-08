require "rails_helper"

describe Lawyer::RegisterContext do
  let!(:lawyer) { FactoryGirl.create :lawyer }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_confirm_mail) }
    end

    context "without policy agreement" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }) }
      it { expect { subject.perform }.to change { subject.errors } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_confirm_mail) }
    end

    context "empty email" do
      subject { described_class.new(lawyer: { name: lawyer.name }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:date_blank] } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "empty name" do
      subject { described_class.new(lawyer: { email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:date_blank] } }
    end

    context "lawyer not found" do
      subject { described_class.new(lawyer: { name: "阿英阿紅", email: "a@example.com" }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_not_found] } }
    end

    context "lawyer already confirmed" do
      before { lawyer.confirm! }
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1") }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_exist] } }
    end
  end

end
