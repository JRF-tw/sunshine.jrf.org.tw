require 'rails_helper'

describe Admin::LawyerDeleteContext do

  context 'success' do
    let!(:lawyer) { create :lawyer }
    subject { described_class.new(lawyer) }
    it { expect { subject.perform }.to change { Lawyer.count }.by(-1) }
  end

  context 'has verdict' do
    let!(:lawyer_with_verdict) { create :lawyer, :with_verdict }
    subject { described_class.new(lawyer_with_verdict) }
    it { expect { subject.perform }.not_to change { Lawyer.count } }
  end

  context 'already confirmed' do
    let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
    subject { described_class.new(lawyer) }

    it { expect { subject.perform }.not_to change { Lawyer.count } }
  end
end
