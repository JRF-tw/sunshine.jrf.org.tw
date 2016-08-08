require "rails_helper"

describe Party::RegisterCheckContext do
  subject { described_class.new(params) }

  describe "#perofrm" do
    context "success" do
      let!(:params) { { party: { name: "老夫子", identify_number: "F122121211", password: "123123123", password_confirmation: "123123123" } } }
      it { expect(subject.perform).to be_truthy }
    end

    context "fail" do
      context "password empty" do
        let!(:params) { { party: { name: "老夫子", identify_number: "F122121211", password: "", password_confirmation: "" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "password too short" do
        let!(:params) { { party: { name: "老夫子", identify_number: "F122121211", password: "1111", password_confirmation: "1111" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "password different" do
        let!(:params) { { party: { name: "老夫子", identify_number: "F122121211", password: "22222222", password_confirmation: "11111111" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "id exist" do
        let!(:party) { create(:party) }
        let!(:params) { { party: { name: "老夫子", identify_number: party.identify_number, password: "22222222", password_confirmation: "11111111" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "id empty" do
        let!(:party) { create(:party) }
        let!(:params) { { party: { name: "老夫子", identify_number: "", password: "22222222", password_confirmation: "11111111" } } }
        it { expect(subject.perform).to be_falsey }
      end

      context "name empty" do
        let!(:party) { create(:party) }
        let!(:params) { { party: { name: "", identify_number: "F122121211", password: "22222222", password_confirmation: "11111111" } } }
        it { expect(subject.perform).to be_falsey }
      end
    end
  end
end
