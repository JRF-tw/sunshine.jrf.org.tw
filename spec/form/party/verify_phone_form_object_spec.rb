require "rails_helper"

RSpec.describe Party::VerifyPhoneFormObject, type: :model do
  let!(:party) { create :party }
  before { party.unconfirmed_phone = "0922888888" }
  before { party.phone_varify_code = "1111" }
  let(:form_object) { Party::VerifyPhoneFormObject.new(party, params) }

  describe "validate" do
    context "success" do
      let(:params) { { phone_varify_code: "1111" } }
      it { expect(form_object.valid?).to be_truthy }
    end

    context "fail" do
      context "empty code" do
        let(:params) { { phone_varify_code: "" } }
        it { expect(form_object.valid?).to be_falsey }
      end

      context "wrong code" do
        let(:params) { { phone_varify_code: "1122" } }
        it { expect(form_object.valid?).to be_falsey }
      end
    end
  end

  describe "#save" do
    before { form_object.save }

    context "success" do
      let(:params) { { phone_varify_code: "1111" } }
      it { expect(party.reload.phone_number).to eq("0922888888") }
    end

    context "fail" do
      let(:params) { { phone_varify_code: "1122" } }
      it { expect(party.reload.phone_number).not_to eq("0922888888") }
    end
  end
end
