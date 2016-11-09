require 'rails_helper'

RSpec.describe Scrap::ImportVerdictContext, type: :model do
  let!(:court) { create :court, code: 'TPH', full_name: '臺灣高等法院' }
  let!(:judge) { create :judge, name: '施俊堯' }
  let!(:branch) { create :branch, court: court, judge: judge, chamber_name: '臺灣高等法院刑事庭', name: '丙' }
  let!(:orginal_data) { Mechanize.new.get(Scrap::ParseVerdictContext::VERDICT_URI).body.force_encoding('UTF-8') }
  let!(:content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/judgment_content.txt") }
  let!(:ruling_content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling_content.html") }
  let!(:word) { '105,上易緝,2' }
  let!(:publish_date) { Time.zone.today }
  let!(:stroy_type) { '刑事' }

  describe '#perform' do
    subject { described_class.new(court, orginal_data, content, word, publish_date, stroy_type).perform }

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

    context 'assign default value' do
      before { subject }
      it { expect(subject.is_judgment).to be_truthy }
    end

    context 'upload file to s3' do
      it { expect(subject.file).to be_present }
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
        it { expect(subject.story.is_pronounce).to be_truthy }
      end

      context 'sync is adjudge to story' do
        it { expect(subject.story.is_adjudge).to be_truthy }
      end
    end

    context 'update adjudge date' do
      context 'story unexist adjudge_date' do
        it { expect(subject.story.adjudge_date).to be_truthy }
        it { expect(subject.adjudge_date).to be_truthy }
      end

      context 'story exist adjudge_date' do
        before { subject.story.update_attributes(adjudge_date: Time.zone.today - 1.day) }

        it { expect { subject }.not_to change { subject.story.adjudge_date } }
      end
    end

    context 'update pronounce_date' do
      context 'story unexist pronounce_date' do
        it { expect(subject.story.pronounce_date).to be_truthy }
      end

      context 'story exist pronounce_date' do
        before { subject.story.update_attributes(pronounce_date: Time.zone.today - 1.day) }

        it { expect { subject }.not_to change { subject.story.pronounce_date } }
      end
    end

    context 'create relations' do
      context 'verdict_relations' do
        let!(:judge1) { create :judge, name: '李麗珠' }
        let!(:lawyer) { create :lawyer, name: '陳圈圈' }
        let!(:party) { create :party, name: '張坤樹' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '臺灣高等法院刑事庭' }

        it { expect { subject }.to change { VerdictRelation.count }.by(4) }
      end

      context 'story_relations' do
        let!(:judge1) { create :judge, name: '李麗珠' }
        let!(:lawyer) { create :lawyer, name: '陳圈圈' }
        let!(:party) { create :party, name: '張坤樹' }
        let!(:branch1) { create :branch, court: court, judge: judge1, chamber_name: '臺灣高等法院刑事庭' }

        it { expect { subject }.to change { StoryRelation.count }.by(4) }
      end
    end

    context '#alert_new_story_type' do
      context 'alert' do
        let!(:stroy_type) { '新der案件類別' }
        subject { described_class.new(court, orginal_data, content, word, publish_date, stroy_type).perform }
        it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context 'not alert' do
        subject { described_class.new(court, orginal_data, content, word, publish_date, stroy_type).perform }
        it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context 'only create judgment verdict' do
      subject { described_class.new(court, orginal_data, ruling_content, word, publish_date, stroy_type).perform }
      it { expect { subject }.not_to change { Verdict.count } }
    end
  end
end
