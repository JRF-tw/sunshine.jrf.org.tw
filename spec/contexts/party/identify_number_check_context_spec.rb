require "rails_helper"

describe Party::IdentifyNumberCheckContext do
  subject { described_class.new(params) }

  describe "#perofrm" do
    context "success" do
      let!(:params) { { party: { name: "老夫子", identify_number: "F122121211" }, policy_agreement: "1" } }
      it { expect(subject.perform).to be_truthy }
    end

    context "fail" do
      context "without policy_agreement" do
        let!(:params) { { party: { name: "老夫子", identify_number: "F122121211" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "other context already test on register_check_context" do
      end
    end
  end
end
