require "rails_helper"

describe CourtObserver::RegisterCheckContext do
  subject { described_class.new(params) }

  describe "#perofrm" do
    context "success" do
      let!(:params) { { court_observer: { name: "老夫子", email: "hh5566@gmail.com", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" } }
      it { expect(subject.perform).to be_truthy }
    end

    context "fail" do
      context "name empty" do
        let!(:params) { { court_observer: { name: "", email: "hh5566@gmail.com", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" } }
        it { expect(subject.perform).to be_falsey }
      end

      context "email empty" do
        let!(:params) { { court_observer: { name: "老夫子", email: "", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" } }
        it { expect(subject.perform).to be_falsey }
      end

      context "password empty" do
        let!(:params) { { court_observer: { name: "老夫子", email: "hh5566@gmail.com", password: "", password_confirmation: "" }, policy_agreement: "1" } }
        it { expect(subject.perform).to be_falsey }
      end

      context "password too short" do
        let!(:params) { { court_observer: { name: "老夫子", email: "hh5566@gmail.com", password: "1111", password_confirmation: "1111" }, policy_agreement: "1" } }
        it { expect(subject.perform).to be_falsey }
        it { expect { subject.perform }.to change { subject.errors[:password_less_than_minimum] } }
      end

      context "password different" do
        let!(:params) { { court_observer: { name: "老夫子", email: "hh5566@gmail.com", password: "22222222", password_confirmation: "11111111" }, policy_agreement: "1" } }
        it { expect(subject.perform).to be_falsey }
        it { expect { subject.perform }.to change { subject.errors[:password_not_match_confirmation] } }
      end

      context "use other's email" do
        let!(:court_observer) { create :court_observer }
        let(:params) { { court_observer: { name: "老夫子", email: court_observer.email, password: "22222222", password_confirmation: "22222222" }, policy_agreement: "1" } }

        it { expect(subject.perform).to be_falsey }
        it { expect { subject.perform }.to change { subject.errors[:observer_already_confirm] } }
      end

      context "use invalid email" do
        let(:params) { { court_observer: { name: "老夫子", email: "dddd", password: "22222222", password_confirmation: "22222222" }, policy_agreement: "1" } }

        it { expect(subject.perform).to be_falsey }
        it { expect { subject.perform }.to change { subject.errors[:email_pattern_invalid] } }
      end

      context "without policy agreement" do
        let(:params) { { court_observer: { name: "老夫子", email: "hh5566@gmail.com", password: "22222222", password_confirmation: "22222222" } } }
        it { expect { subject.perform }.to change { subject.errors[:without_policy_agreement] } }
        it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_setting_password_mail) }
      end
    end
  end
end
