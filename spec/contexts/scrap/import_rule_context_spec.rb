require 'rails_helper'

RSpec.describe Scrap::ImportRuleContext, type: :model do
  let!(:court) { create :court, code: 'TNH', full_name: '臺灣高等法院臺南分院' }
  let!(:judge) { create :judge, name: '林英志' }
  let!(:branch) { create :branch, court: court, judge: judge, chamber_name: '臺灣高等法院臺南分院刑事第六庭', name: '丙' }
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/rule.html") }
  let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/rule_content.txt") }

  let!(:word) { '106,台抗,94' }
  let!(:published_on) { Time.zone.today }
  let!(:story_type) { '刑事' }

  describe '#perform' do
    subject { described_class.new(court, original_data, content, word, published_on, story_type).perform }

    context 'create rule' do
      it { expect { subject }.to change { Rule.count } }
    end

    context 'find_or_create_story' do
      context 'create' do
        it { expect { subject }.to change { Story.count } }
      end

      context 'find' do
        before { subject }
        it { expect { subject }.not_to change { Story.count } }
      end
    end

    context 'upload file to s3' do
      it { expect(subject.file).to be_present }
    end

    context 'upload content_file to s3' do
      it { expect(subject.content_file).to be_present }
    end

    context 'update data to story' do
      before { subject }
      context 'sync names' do
        it { expect(subject.judges_names).to eq(subject.story.judges_names) }
        it { expect(subject.prosecutor_names).to eq(subject.story.prosecutor_names) }
        it { expect(subject.party_names).to eq(subject.story.party_names) }
        it { expect(subject.lawyer_names).to eq(subject.story.lawyer_names) }
      end

      context 'update story reason' do
        it { expect(subject.story.reason).to be_present }
      end
    end

    context '#alert_new_story_type' do
      context 'alert' do
        let!(:story_type) { '新der案件類別' }
        subject { described_class.new(court, original_data, content, word, published_on, story_type).perform }
        it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context 'not alert' do
        subject { described_class.new(court, original_data, content, word, published_on, story_type).perform }
        it { expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context 'update original_url' do
      it { expect(subject.original_url).to be_present }
    end

    context 'update stories_history_url' do
      it { expect(subject.stories_history_url).to be_present }
    end

    context 'create relations' do
      context 'rule_relations' do
        let!(:judge1) { create :judge, name: '林福來' }
        let!(:lawyer) { create :lawyer, name: '蕭敦仁' }
        let!(:party) { create :party, name: '鄭文玉' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '刑事第六庭' }
        it { expect { subject }.to change { RuleRelation.count }.by(4) }
      end

      context 'story_relations' do
        let!(:judge1) { create :judge, name: '林福來' }
        let!(:lawyer) { create :lawyer, name: '蕭敦仁' }
        let!(:party) { create :party, name: '鄭文玉' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '刑事第六庭' }

        it { expect { subject }.to change { StoryRelation.count }.by(4) }
      end
    end
  end
end
