require 'rails_helper'

describe Admin::LawyerDeleteContext do

  context "success" do
    let!(:lawyer) {FactoryGirl.create :lawyer}
    subject { described_class.new(lawyer) }
    it { expect { subject.perform }.to change { Lawyer.count }.by(-1) }
  end

  context "has story" do
    let!(:lawyer_with_verdict) { FactoryGirl.create :lawyer, :with_verdict }
    subject { described_class.new(lawyer_with_verdict) }
    it { expect { subject.perform }.not_to change { Lawyer.count } }
  end

  context "already confirmed" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
    subject { described_class.new(lawyer) }

    it { expect { subject.perform }.not_to change { Lawyer.count } }
  end
end
