require "rails_helper"

describe Admin::CourtDeleteContext do
  let(:court) { FactoryGirl.create(:court) }

  describe "#perform" do
    context "success" do
      subject! { described_class.new(court) }
      it { expect { subject.perform }.to change { Court.count }.by(-1) }
    end
  end

end
