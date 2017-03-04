require 'rails_helper'

RSpec.describe Scrap::ImportJudgeContext, type: :model do
  let!(:court) { create :court, code: 'TPH', scrap_name: '臺灣高等法院' }

  describe '#perform' do
    let(:data_string) { '臺灣高等法院民事庭,乙,匡偉　法官,黃千鶴,2415' }
    subject { described_class.new(data_string).perform }

    context 'success' do
      it { expect(subject.name).to eq('匡偉') }
      it { expect(subject.court).to eq(court) }
      it { expect(subject.branches.last.name).to eq('乙') }
      it { expect(subject.branches.last.chamber_name).to eq('臺灣高等法院民事庭') }
      it { expect { subject }.to change { Judge.count }.by(1) }
    end

    context 'find court with space' do
      let!(:court) { create :court, code: 'TCH', scrap_name: '臺灣高等法院 臺中分院' }
      let(:data_string) { '臺灣高等法院臺中分院民事庭,乙,匡偉　法官,黃千鶴,2415' }

      it { expect { subject }.to change { Judge.count }.by(1) }
    end

    context 'judge exist' do
      let!(:judge) { create :judge, court: court, name: '匡偉' }

      it { expect { subject }.not_to change { Judge.count } }
    end

    context 'judge name with Judicial officer' do
      let(:data_string) { '臺灣高等法院民事庭,乙,匡偉　司法事務官,黃千鶴,2415' }
      it { expect { subject }.to change { Judge.count }.by(1) }
      it { expect(subject.name).to eq('匡偉') }
      it { expect(subject.memo).to eq('司法事務官') }
    end

    context 'judge name with illegal character' do
      let(:data_string) { '臺灣高等法院民事庭,乙,匡偉@司法事務官,黃千鶴,2415' }
      it { expect { subject }.to change { Judge.count }.by(1) }
      it { expect(subject.name).to eq('匡偉') }
      it { expect(subject.memo).to eq('司法事務官') }
    end

    context 'court not exist' do
      let(:data_string) { 'xxxxxx,乙,匡偉　法官,黃千鶴,2415' }

      it { expect(subject).to be_falsey }
    end

    context 'create_branch' do
      it { expect { subject }.to change { Branch.count } }
    end

    context 'record_import_daily_branch' do
      let(:record_object) { Redis::List.new('daily_import_branch_ids') }
      it { expect { subject }.to change { record_object.values.count } }
    end

    context 'record_import_daily_branch' do
      let(:record_object) { Redis::List.new('daily_import_branch_ids') }
      it { expect { subject }.to change { record_object.values.count } }
    end
  end
end
