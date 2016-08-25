require "rails_helper"

describe Party::ToggleSubscribeEdmContext do
  let!(:party) { create :party, :already_confirmed }

  context "perform" do
    context "success" do
      subject { described_class.new(party) }
      it { expect(subject.perform).to be_truthy }
      it { expect{ subject.perform }.to change { party.reload.subscribe_edm } }
    end

    context "toggle to false" do
      subject { described_class.new(party) }
      before { subject.perform }
      it { expect{ subject.perform }.to change { party.reload.subscribe_edm }.from(true).to(false) }
    end

    context "party unconfirmed email" do
      let!(:party) { create :party, :with_unconfirmed_email }
      subject { described_class.new(party) }
      it { expect(subject.perform).to be_falsey }
      it { expect{ subject.perform }.not_to change { party.reload.subscribe_edm } }
    end
  end
end
