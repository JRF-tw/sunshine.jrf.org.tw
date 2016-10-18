require "rails_helper"

RSpec.describe Party::ChangePhoneFormObject, type: :model do
  let!(:party) { create :party }
  let(:form_object) { Party::ChangePhoneFormObject.new(party, params) }

  describe "validate" do
    context "success" do
      let(:params) { { unconfirmed_phone: "0922888888" } }
      it { expect(form_object.valid?).to be_truthy }
    end

    context "fail" do
      context "empty phone_number" do
        let(:params) { { unconfirmed_phone: "" } }
        it { expect(form_object.valid?).to be_falsey }
      end

      context "invalid phone_number" do
        let(:params) { { unconfirmed_phone: "002xx" } }
        it { expect(form_object.valid?).to be_falsey }
      end

      context "same phone_number" do
        let(:params) { { unconfirmed_phone: party.phone_number } }
        it { expect(form_object.valid?).to be_falsey }
      end

      context "exist phone_number" do
        let!(:party2) { create :party }
        let(:params) { { unconfirmed_phone: party2.phone_number } }
        it { expect(form_object.valid?).to be_falsey }
      end

      context "exist unconfirm_phone_number" do
        let!(:party2) { create :party }
        let(:params) { { unconfirmed_phone: "0922888888" } }
        before { party2.unconfirmed_phone = "0922888888" }
        it { expect(form_object.valid?).to be_falsey }
      end
    end
  end

  describe "#save" do
    context "success" do
      let(:params) { { unconfirmed_phone: "0922888888" } }
      before { form_object.save }
      it { expect(party.unconfirmed_phone.value).to eq("0922888888") }
    end

    context "fail" do
      let(:params) { { unconfirmed_phone: "4022888888" } }
      before { form_object.save }
      it { expect(party.unconfirmed_phone.value).to be_nil }
    end
  end

end
