require 'rails_helper'

describe Import::GetLawyerContext do
  let(:lawyer_url) { 'http://gist.githubusercontent.com/raw/lawyer.csv/' }
  subject { described_class.new(lawyer_url).perform }

  describe '#perform' do
    context 'import four lawyers' do
      it { expect { subject }.to change { Lawyer.count }.by(4) }
    end
  end
end
