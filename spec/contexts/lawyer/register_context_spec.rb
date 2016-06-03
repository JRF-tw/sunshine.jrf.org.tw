require 'rails_helper'

describe Lawyer::RegisterContext do
  let!(:lawyer) { FactoryGirl.create :lawyer }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }) }
      it { expect { subject.perform }.to_not change { subject.errors } }
      
    end

    context "invalidate params" do
      subject { described_class.new(lawyer: { name: lawyer.name }) }
      it { expect { subject.perform }.to change { subject.errors[:date_blank] } }
    end


    context "lawyer not found" do
      subject { described_class.new(lawyer: { name: "阿英阿紅", email: 'a@example.com' }) }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_not_found] } }
    end

    context "lawyer already confirmed" do
      before { lawyer.confirm! }
      subject { described_class.new(lawyer: { name: lawyer.name, email: lawyer.email }) }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_exist] } }
    end
  end

end
