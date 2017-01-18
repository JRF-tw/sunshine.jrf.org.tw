require 'rails_helper'

RSpec.describe Scrap::ImportSupremeCourtJudgeContext, type: :model do
  describe '#perform' do
    let!(:court) { create :court, full_name: '最高法院', name: '最高院', code: 'TPS' }
    let(:data_array) { ['周舒雁', '翔', '刑事庭'] }
    subject { described_class.new(data_array).perform }

    context 'success' do
      it { expect(subject.name).to eq('周舒雁') }
      it { expect(subject.court).to eq(court) }
      it { expect(subject.branches.last.name).to eq('翔') }
      it { expect(subject.branches.last.chamber_name).to eq('刑事庭') }
      it { expect { subject }.to change { Judge.count }.by(1) }
    end

    context 'judge exist' do
      let!(:judge) { create :judge, court: court, name: '周舒雁' }

      it { expect { subject }.not_to change { Judge.count } }
    end

    context 'court not exist' do
      before { Court.destroy_all }

      it { expect { subject }.to change { Court.count }.by(1) }
    end

    context 'create_branch' do
      it { expect { subject }.to change { Branch.count } }
    end

    context 'record_import_daily_branch' do
      let(:record_object) { Redis::List.new('import_supreme_branch_ids') }
      it { expect { subject }.to change { record_object.values.count } }
    end
  end
end
