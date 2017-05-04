require 'rails_helper'

describe Scrap::UpdateRefereeByFileContext do
  before { create :crawler_history }

  describe 'perform' do
    context 'verdict' do
      let!(:verdict) { create :verdict }
      subject { described_class.new(verdict, Scrap::ParseRefereeContext::REFEREE_URI).perform }

      it { expect { subject }.to change { verdict.reason } }
      it { expect { subject }.to change { verdict.original_url } }
      it { expect { subject }.to change { verdict.stories_history_url } }
    end

    context 'rule' do
      let!(:rule) { create :rule }
      subject { described_class.new(rule, Scrap::ParseRefereeContext::REFEREE_URI).perform }

      it { expect { subject }.to change { rule.reason } }
      it { expect { subject }.to change { rule.original_url } }
      it { expect { subject }.to change { rule.stories_history_url } }
    end
  end
end
