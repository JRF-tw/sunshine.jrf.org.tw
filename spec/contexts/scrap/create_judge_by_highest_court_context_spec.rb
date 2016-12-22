require 'rails_helper'

RSpec.describe Scrap::CreateJudgeByHighestCourtContext, type: :model do
  describe '#perform' do
    let!(:court) { create :court, code: 'TPS', scrap_name: '最高法院' }
    let!(:court1) { create :court, code: 'TPX', scrap_name: 'OOOOOOO' }
    let!(:name) { 'xxx' }
    subject { described_class.new(court, name).perform }

    describe '#is_highest_court?' do
      context 'is highest' do
        subject { described_class.new(court, name).perform }
        it { expect(subject).to be_truthy }
      end

      context 'not highest' do
        subject { described_class.new(court1, name).perform }
        it { expect(subject).to be_falsey }
        it { expect { subject }.not_to change { Judge.count } }
      end
    end

    context 'already has judge' do
      let!(:judge) { create :judge, name: 'xxx', court: court }

      it { expect { subject }.not_to change { Judge.count } }
    end

    context 'create new judge' do
      it { expect { subject }.to change { Judge.count } }
    end

    describe '#assign_to_redis' do
      let!(:redis_object) { Redis::HashKey.new('higest_court_judge_created') }
      context 'new record' do
        it { expect { subject }.to change { redis_object.all.count } }
      end

      context 'not new record' do
        let!(:judge) { create :judge, name: 'xxx', court: court }
        it { expect { subject }.not_to change { redis_object.all.count } }
      end
    end
  end
end
