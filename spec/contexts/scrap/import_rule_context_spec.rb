require 'rails_helper'

RSpec.describe Scrap::ImportRuleContext, type: :model do
  let!(:court) { create :court, code: 'TPS', full_name: '最高法院' }
  let!(:judge) { create :judge, name: '洪昌宏' }
  let!(:branch) { create :branch, court: court, judge: judge, chamber_name: '最高法院刑事第八庭', name: '丙' }
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling.html") }
  let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling_content.txt") }

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

    context 'update abs_url' do
      it { expect(subject.abs_url).to be_present }
    end
  end
end
