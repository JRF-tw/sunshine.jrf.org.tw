require 'rails_helper'

RSpec.describe Defendant, type: :model do
  let(:defendant){ FactoryGirl.create :defendant }
  it "FactoryGirl" do
    expect(defendant).not_to be_new_record
  end

  describe "#set_reset_password_token" do
    context "generate reset token" do
      subject! { defendant.set_reset_password_token }
      it { expect(defendant.reload.reset_password_token).to be_present }
      it { expect(defendant.reload.reset_password_sent_at).to be_present }
    end
  end

  describe "validate" do
    context "success" do
      let(:defendant_re) { Defendant.new(name: "aron", identify_number: "S211111111", password: "11111111") }
      it { expect(defendant_re.valid?).to eq(true) }
    end

    context "success with phone_number" do
      let(:defendant_re) { Defendant.new(name: "aron", identify_number: "S211111111", password: "11111111", phone_number: "0911111111") }
      it { expect(defendant_re.valid?).to eq(true) }
    end

    context "identify_number empty" do
      let(:defendant_re) { Defendant.new(name: "aron", identify_number: "", password: "11111111") }
      it { expect(defendant_re.valid?).to eq(false) }
    end

    context "identify_number doesn't match" do
      let(:defendant_re) { Defendant.new(name: "aron", identify_number: "S311111111") }
      it { expect(defendant_re.valid?).to eq(false) }
    end

    context "phone_number doesn't match" do
      let(:defendant_re) { Defendant.new(name: "aron", identify_number: "S111111111", phone_number: "0811294939") }
      it { expect(defendant_re.valid?).to eq(false) }
    end
  end

  describe "#phone_unconfirm!" do
    before { defendant.phone_confirm! }
    it { expect{ defendant.phone_unconfirm! }.to change { defendant.phone_confirmed? } }
  end

  describe "#phone_confirm!" do
    it { expect{ defendant.phone_confirm! }.to change { defendant.phone_confirmed? } }
  end

  describe "#phone_confirmed?" do
    context "should truthy" do
      before { defendant.phone_confirm! }
      it { expect(defendant.phone_confirmed?).to be_truthy }
    end

    context "should falsey" do
      before { defendant.phone_unconfirm! }
      it { expect(defendant.phone_confirmed?).to be_falsey }
    end
  end
end
