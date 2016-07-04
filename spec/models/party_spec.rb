require "rails_helper"

RSpec.describe Party, type: :model do
  let(:party) { FactoryGirl.create :party }
  it "FactoryGirl" do
    expect(party).not_to be_new_record
  end

  describe "#set_reset_password_token" do
    context "generate reset token" do
      subject! { party.set_reset_password_token }
      it { expect(party.reload.reset_password_token).to be_present }
      it { expect(party.reload.reset_password_sent_at).to be_present }
    end
  end

  describe "validate" do
    context "success" do
      let(:party_re) { Party.new(name: "aron", identify_number: "S211111111", password: "11111111") }
      it { expect(party_re.valid?).to eq(true) }
    end

    context "success with phone_number" do
      let(:party_re) { Party.new(name: "aron", identify_number: "S211111111", password: "11111111", phone_number: "0911111111") }
      it { expect(party_re.valid?).to eq(true) }
    end

    context "identify_number empty" do
      let(:party_re) { Party.new(name: "aron", identify_number: "", password: "11111111") }
      it { expect(party_re.valid?).to eq(false) }
    end

    context "identify_number doesn't match" do
      let(:party_re) { Party.new(name: "aron", identify_number: "S311111111") }
      it { expect(party_re.valid?).to eq(false) }
    end

    context "phone_number doesn't match" do
      let(:party_re) { Party.new(name: "aron", identify_number: "S111111111", phone_number: "0811294939") }
      it { expect(party_re.valid?).to eq(false) }
    end
  end

  describe "#phone_unconfirm!" do
    before { party.phone_confirm! }
    it { expect { party.phone_unconfirm! }.to change { party.phone_confirmed? } }
  end

  describe "#phone_confirm!" do
    it { expect { party.phone_confirm! }.to change { party.phone_confirmed? } }
  end

  describe "#phone_confirmed?" do
    context "should truthy" do
      before { party.phone_confirm! }
      it { expect(party.phone_confirmed?).to be_truthy }
    end

    context "should falsey" do
      before { party.phone_unconfirm! }
      it { expect(party.phone_confirmed?).to be_falsey }
    end
  end
end
