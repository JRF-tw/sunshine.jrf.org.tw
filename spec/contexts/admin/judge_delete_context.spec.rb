require "rails_helper"

describe Admin::JudgeDeleteContext do
  let(:judge) { FactoryGirl.create(:judge) }

  describe "#perform" do
    context "success" do
      subject! { described_class.new(judge) }
      it { expect { subject.perform }.to change { Judge.count }.by(-1) }
    end
  end

end
