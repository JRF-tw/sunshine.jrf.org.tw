require 'rails_helper'

describe Lawyer::ShowSetPasswordContext do
  let!(:lawyer) { FactoryGirl.create :lawyer }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer) }
      it { expect(subject.perform).to be true }
    end

    context "empty lawyer" do
      subject { described_class.new }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_not_found] } }
    end

    context "lawyer already confirmed" do
      before { lawyer.confirm! }
      subject { described_class.new(lawyer) }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_exist] } }
    end
  end

end
