require "rails_helper"

describe Admin::CourtWeightUpdateContext do
  let!(:court1) { create(:court) }
  let!(:court2) { create(:court) }
  let!(:court3) { create(:court) }

  describe "#perform" do
    context "success" do

      def to_first(court)
        Admin::CourtWeightUpdateContext.new(court).perform(weight: "first")
        expect(court.first?).to be_truthy
      end

      def to_last(court)
        Admin::CourtWeightUpdateContext.new(court).perform(weight: "last")
        expect(court.last?).to be_truthy
      end

      def to_up(court)
        origin_weight = court.weight
        Admin::CourtWeightUpdateContext.new(court).perform(weight: "up")
        expect(court.reload.weight).to eq(origin_weight - 1)
      end

      def to_down(court)
        origin_weight = court.weight
        Admin::CourtWeightUpdateContext.new(court).perform(weight: "down")
        expect(court.reload.weight).to eq(origin_weight + 1)
      end

      context "sorting" do
        before { to_last(court1) }
        before { to_last(court2) }
        before { to_last(court3) }

        it { expect { to_last(court1) }.to change { court1.weight }.to(3) }
        it { expect { to_first(court3) }.to change { court3.weight }.to(1) }
        it { expect { to_up(court3) }.to change { court3.weight }.to(2) }
        it { expect { to_down(court1) }.to change { court1.weight }.to(2) }
      end

    end
  end

end
