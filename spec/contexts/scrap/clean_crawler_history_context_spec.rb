require 'rails_helper'

describe Scrap::CleanCrawlerHistoryContext do
  before { create :crawler_history }
  before { create :crawler_history, crawler_on: Time.zone.today - 2.months }

  describe 'perform' do
    context 'success' do
      subject { described_class.new.perform }
      it { expect { subject }.to change { CrawlerHistory.count } }
    end
  end
end
