require "rails_helper"

describe Party::SetPhoneContext do
  let!(:party) { FactoryGirl.create :party }
  let!(:params) { { phone_number: "0911111111" } }
  subject { described_class.new(party) }

  describe "#perform" do
    context "check_phone" do
      let!(:params) { { phone_number: "" } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_phone_format" do
      let!(:params) { { phone_number: "092112312x" } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_unexist_phone_number" do
      let!(:party1) { FactoryGirl.create :party, phone_number: params[:phone_number] }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_phone_not_the_same" do
      let!(:party1) { FactoryGirl.create :party }
      let!(:params) { { phone_number: party.phone_number } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_unexist_unconfirmed_phone" do
      let!(:party1) { FactoryGirl.create :party }
      before { party1.unconfirmed_phone = params[:phone_number] }

      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_sms_send_count" do
      before { party.sms_sent_count.value = 2 }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "success" do
      it { expect { subject.perform(params) }.to change { party.sms_sent_count.value } }
      it { expect { subject.perform(params) }.to change_sidekiq_jobs_size_of(SmsService, :send_to) }

      context "assign_value" do
        before { subject.perform(params) }

        it { expect(party.phone_varify_code.value).to be_present }
        it { expect(party.unconfirmed_phone).to eq(params[:phone_number]) }
      end

      context "set_unconfirm" do
        before { subject.perform(params) }

        it { expect(party.confirmed?).to be_falsey }
      end
    end
  end
end
