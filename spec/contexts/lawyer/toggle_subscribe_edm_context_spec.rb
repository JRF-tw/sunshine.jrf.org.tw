require "rails_helper"

describe Lawyer::ToggleSubscribeEdmContext do
  let!(:lawyer) { create :lawyer }
  subject { described_class.new(lawyer) }

  context "perform" do
    context "success" do
      it { expect(subject.perform).to be_truthy }
      it { expect { subject.perform }.to change { lawyer.reload.subscribe_edm } }
    end

    context "toggle to false" do
      before { subject.perform }
      it { expect { subject.perform }.to change { lawyer.reload.subscribe_edm }.from(true).to(false) }
    end
  end
end
