require "rails_helper"

RSpec.describe ScheduleScore do
  let(:schedule_score) { FactoryGirl.create :schedule_score }

  describe "FactoryGirl" do
    context "normalize" do
      subject! { schedule_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
