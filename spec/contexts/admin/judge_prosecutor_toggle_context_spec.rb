require 'rails_helper'

describe Admin::JudgeProsecutorToggleContext do
  subject { described_class }

  shared_examples 'judge to prosecutor' do
    it { expect(Prosecutor.last.is_active).to be_truthy }
    it { expect(Prosecutor.last.is_hidden).to be_falsey }
    it { expect(Prosecutor.last.is_judge).to be_falsey }
    it { expect(Prosecutor.last.prosecutors_office.court).to eq(judge.court) }
    it { expect(judge.reload.is_hidden).to be_truthy }
    it { expect(judge.reload.is_active).to be_falsey }
    it { expect(judge.reload.is_prosecutor).to be_truthy }
    it { expect(judge.reload.prosecutor).to eq(Prosecutor.last) }
  end

  shared_examples 'prosecutor to judge' do
    it { expect(Judge.last.is_active).to be_truthy }
    it { expect(Judge.last.is_hidden).to be_falsey }
    it { expect(Judge.last.is_prosecutor).to be_falsey }
    it { expect(Judge.last.court.prosecutors_office).to eq(prosecutor.prosecutors_office) }
    it { expect(prosecutor.is_hidden).to be_truthy }
    it { expect(prosecutor.is_active).to be_falsey }
    it { expect(prosecutor.is_judge).to be_truthy }
    it { expect(prosecutor.reload.judge).to eq(Judge.last) }
  end

  describe '#perform' do
    context 'judge -> prosecutor' do
      let!(:judge) { create :judge }
      let!(:prosecutors_office) { create :prosecutors_office, court: judge.court }
      context 'prosecutor exist' do
        let!(:prosecutor) { create :prosecutor, prosecutors_office: prosecutors_office, name: judge.name, judge: judge }
        before { subject.new(judge).perform }
        it_behaves_like 'judge to prosecutor'
      end

      context 'prosecutor exist but not in relation' do
        let!(:prosecutor) { create :prosecutor, prosecutors_office: prosecutors_office, name: judge.name }
        before { subject.new(judge).perform }
        it_behaves_like 'judge to prosecutor'
      end

      context 'prosecutor not exist' do
        before { subject.new(judge).perform }
        it_behaves_like 'judge to prosecutor'
        it { expect(Prosecutor.count).to eq(1) }
      end

      context 'court without prosecutors_office' do
        before { prosecutors_office.destroy }
        it { expect { subject.new(judge.reload).perform }.not_to change { Prosecutor.count } }
      end
    end

    context 'prosecutor -> judge' do
      let!(:prosecutor) { create :prosecutor }
      let!(:court) { create :court, prosecutors_office: prosecutor.prosecutors_office }

      context 'judge exist' do
        let!(:judge) { create :judge, court: court, name: prosecutor.name, prosecutor: prosecutor }
        before { subject.new(prosecutor).perform }
        it_behaves_like 'prosecutor to judge'
      end

      context 'judge exist but not in relation' do
        let!(:judge) { create :judge, court: court, name: prosecutor.name }
        before { subject.new(prosecutor).perform }
        it_behaves_like 'prosecutor to judge'
      end

      context 'judge not exist' do
        before { subject.new(prosecutor).perform }
        it_behaves_like 'prosecutor to judge'
        it { expect(Judge.count).to eq(1) }
      end

      context 'prosecutors_office without court' do
        before { court.destroy }
        it { expect { subject.new(prosecutor.reload).perform }.not_to change { Judge.count } }
      end
    end

    context 'invaild_role' do
      let!(:party) { create :party }
      it { expect(subject.new(party).perform).to be_falsey }
    end
  end

end
