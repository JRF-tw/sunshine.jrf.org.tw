require 'rails_helper'

describe Import::CreateRefereeContext do
  let!(:hash_data) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/TYD103簡聲抗18.json")) }
  subject { described_class.new(hash_data).perform }
  describe '#perform' do
    context 'success' do
      let!(:court) { create :court, full_name: '臺灣桃園地方法院', code: 'TYD' }

      context 'find_or_create_rule' do
        context 'create' do
          it { expect { subject }.to change { Rule.count } }
        end

        context 'find' do
          before { subject }
          it { expect { subject }.not_to change { Rule.count } }
        end
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
    end

    context 'court not exist' do
      it { expect(subject).to be_falsey }
    end
  end
end
