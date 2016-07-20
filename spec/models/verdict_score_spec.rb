require "rails_helper"

RSpec.describe VerdictScore do
  let(:verdict_score) { FactoryGirl.create :verdict_score }

  describe "FactoryGirl" do
    context "normalize" do
      subject! { verdict_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
