require 'rails_helper'

describe Scrap::NotifyAbnormalDataContext do
  let!(:crawler_history) { create :crawler_history }

  describe 'perform' do
    context '#check_crawler_execute' do
      context 'scrap court on monday' do
        before { crawler_history.update_attributes(crawler_on: Time.zone.today.beginning_of_week) }
        subject { described_class.new(crawler_history) }
        it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(4) }
      end

      context 'courts should not notify' do
        before { crawler_history.update_attributes(crawler_on: Time.zone.today.end_of_week) }
        subject { described_class.new(crawler_history) }
        it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(3) }
      end
    end

    context '#check_parse_verdict_validity' do
      context 'validity out of expect' do
        let!(:crawler_history) { create :crawler_history, :exist_counts, verdicts_count: 10 }
        let!(:crawler_log) { create :crawler_log, :judge_parse_error, crawler_history: crawler_history }
        subject { described_class.new(crawler_history) }
        it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(1) }
      end
    end
  end

end
