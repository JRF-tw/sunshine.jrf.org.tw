require 'rails_helper'

RSpec.describe Scrap::ImportVerdictContext, type: :model do
  let!(:court) { create :court, code: 'TCH', full_name: '臺灣高等法院臺中分院' }
  let!(:judge) { create :judge, name: '鄭永玉' }
  let!(:branch) { create :branch, court: court, judge: judge, chamber_name: '臺灣高等法院臺中分院刑事第五庭', name: '丙' }
  let!(:original_data) { Mechanize.new.get(Scrap::ParseRefereeContext::REFEREE_URI).body.force_encoding('UTF-8') }
  let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_content.txt") }
  let!(:word) { '105,原選上訴,1' }
  let!(:published_on) { Time.zone.today }
  let!(:story_type) { '刑事' }

  describe '#perform' do
    subject { described_class.new(court, original_data, content, word, published_on, story_type).perform }

    context 'create verdict' do
      it { expect { subject }.to change { Verdict.count } }
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

      context 'sync is pronounce to story' do
        it { expect(subject.story.is_pronounced).to be_truthy }
      end

      context 'sync is adjudge to story' do
        it { expect(subject.story.is_adjudged).to be_truthy }
      end

      context 'update story reason' do
        it { expect(subject.story.reason).to be_present }
      end
    end

    context 'update adjudge date' do
      context 'story unexist adjudged_on' do
        it { expect(subject.story.adjudged_on).to be_truthy }
        it { expect(subject.adjudged_on).to be_truthy }
      end

      context 'story exist adjudged_on' do
        before { subject.story.update_attributes(adjudged_on: Time.zone.today - 1.day) }

        it { expect { subject }.not_to change { subject.story.adjudged_on } }
      end
    end

    context 'update pronounced_on' do
      context 'story unexist pronounced_on' do
        it { expect(subject.story.pronounced_on).to be_truthy }
      end

      context 'story exist pronounced_on' do
        before { subject.story.update_attributes(pronounced_on: Time.zone.today - 1.day) }

        it { expect { subject }.not_to change { subject.story.pronounced_on } }
      end
    end

    context 'create relations' do
      context 'verdict_relations' do
        let!(:judge1) { create :judge, name: '鍾貴堯' }
        let!(:lawyer) { create :lawyer, name: '張方俞' }
        let!(:party) { create :party, name: '張榮獻' }
        let!(:prosecutor) { create :prosecutor, name: '宋恭良' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '臺灣高等法院刑事庭' }

        it { expect { subject }.to change { VerdictRelation.count }.by(5) }
      end

      context 'story_relations' do
        let!(:judge1) { create :judge, name: '鍾貴堯' }
        let!(:lawyer) { create :lawyer, name: '張方俞' }
        let!(:party) { create :party, name: '張榮獻' }
        let!(:prosecutor) { create :prosecutor, name: '宋恭良' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '臺灣高等法院刑事庭' }

        it { expect { subject }.to change { StoryRelation.count }.by(5) }
      end

      context 'handle many lawyer pattern' do
        let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_with_many_lawyer.text") }
        it { expect(subject.lawyer_names).to eq(['李旦']) }
      end
    end

    context '#calculate_schedule_scores' do
      let(:story_params) { word.split(',') }
      let!(:story) { create :story, year: story_params[0], word_type: story_params[1], number: story_params[2], court: court, story_type: story_type }
      let!(:party) { create :party, name: '張榮獻' }
      let!(:schedule_score) { create :schedule_score, story: story, schedule_rater: party, judge: judge }
      it { expect { subject }.to change { ValidScore.count }.by(1) }
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

    xit '#send_after_verdict_noice, should be test in AfterVerdictNoticeContextSpec'
  end
end
