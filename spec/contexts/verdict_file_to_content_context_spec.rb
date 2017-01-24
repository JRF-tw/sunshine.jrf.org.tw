require 'rails_helper'

describe VerdictFileToContentContext do
  let!(:verdict) { create :verdict, :with_file }
  subject { described_class.new(verdict).perform }

  describe '#perform' do
    before { subject }
    it { expect(verdict.content).to be_present }
  end
end
