require 'rails_helper'

describe Scrap::UpdateRefereeByFileContext do
  before { create :crawler_history }

  describe 'perform' do
    context 'verdict' do
      let!(:verdict) { create :verdict, :with_file }
      subject { described_class.new(verdict).perform }

      it { expect { subject }.to change { verdict.reason } }
      it { expect { subject }.to change { verdict.original_url } }
      it { expect { subject }.to change { verdict.stories_history_url } }
    end

    context 'rule' do
      let!(:rule) { create :rule, :with_file }
      subject { described_class.new(rule).perform }

      it { expect { subject }.to change { rule.reason } }
      it { expect { subject }.to change { rule.original_url } }
      it { expect { subject }.to change { rule.stories_history_url } }
    end
  end
end
