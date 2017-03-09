require 'rails_helper'

RSpec.describe Scrap::Concerns::VerdictCommonStep, type: :model do
  let!(:court) { create :court, code: 'TPS', full_name: '最高法院' }
  let!(:judge) { create :judge, name: '洪昌宏' }
  let!(:branch) { create :branch, court: court, judge: judge, chamber_name: '最高法院刑事第八庭', name: '丙' }
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling.html") }
  let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling_content.txt") }
  let!(:word) { '106,台抗,94' }
  let!(:publish_on) { Time.zone.today }
  let!(:story_type) { '刑事' }

  subject { described_class.new(court: court, original_data: original_data, content: content, word: word, publish_on: publish_on, story_type: story_type) }
  describe '#before_perform_step' do
    context 'create rule if is rule' do
      it { expect { subject.before_perform_step }.to change { Rule.count } }
    end

    context 'create verdict if is verdict' do
      let!(:original_data) { Mechanize.new.get(Scrap::ParseVerdictContext::VERDICT_URI).body.force_encoding('UTF-8') }
      let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/judgment_content.txt") }
      it { expect { subject.before_perform_step }.to change { Verdict.count } }
    end

    context 'find_or_create_story' do
      context 'create' do
        it { expect { subject.before_perform_step }.to change { Story.count } }
      end

      context 'find' do
        before { subject.before_perform_step }
        it { expect { subject.before_perform_step }.not_to change { Story.count } }
      end
    end
  end

  describe '#after_perform_step' do
    context 'upload file to s3' do
      let!(:verdict) { subject.before_perform_step.first }
      before { subject.after_perform_step }

      it { expect(verdict.file).to be_present }
      it { expect(verdict.content_file).to be_present }
    end

    context 'update data to story' do
      let!(:verdict) { subject.before_perform_step.first }
      before { subject.after_perform_step }

      context 'sync names' do
        it { expect(verdict.judges_names).to eq(verdict.story.judges_names) }
        it { expect(verdict.prosecutor_names).to eq(verdict.story.prosecutor_names) }
        it { expect(verdict.party_names).to eq(verdict.story.party_names) }
        it { expect(verdict.lawyer_names).to eq(verdict.story.lawyer_names) }
      end
    end

    context '#alert_new_story_type' do
      context 'alert' do
        let!(:story_type) { '新der案件類別' }
        let!(:verdict) { subject.before_perform_step.first }
        it { expect { subject.after_perform_step }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context 'not alert' do
        before { subject.before_perform_step }
        it { expect { subject.after_perform_step }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context '#record_count_to_daily_notify' do
      context 'verdict' do
        let!(:original_data) { Mechanize.new.get(Scrap::ParseVerdictContext::VERDICT_URI).body.force_encoding('UTF-8') }
        let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/judgment_content.txt") }
        before { subject.before_perform_step }
        before { subject.after_perform_step }
        it { expect(Redis::Counter.new('daily_scrap_verdict_count').value).to eq 1 }
      end

      context 'rule' do
        before { subject.before_perform_step }
        before { subject.after_perform_step }
        it { expect(Redis::Counter.new('daily_scrap_rule_count').value).to eq 1 }
      end
    end
  end
end
