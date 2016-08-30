require "rails_helper"

describe CourtObserver::ToggleSubscribeEdmContext do
  let!(:court_observer) { create :court_observer }
  subject { described_class.new(court_observer) }

  context "perform" do
    context "success" do
      it { expect(subject.perform).to be_truthy }
      it { expect { subject.perform }.to change { court_observer.reload.subscribe_edm } }
    end

    context "toggle to false" do
      before { subject.perform }
      it { expect { subject.perform }.to change { court_observer.reload.subscribe_edm }.from(true).to(false) }
    end
  end
end
