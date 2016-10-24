require 'rails_helper'

describe Party::IdentifyNumberCheckContext do
  subject { described_class.new(params) }

  describe '#perofrm' do
    context 'success' do
      let!(:params) { { party: { name: '老夫子', identify_number: 'F122121211' }, policy_agreement: '1' } }
      it { expect(subject.perform).to be_truthy }
    end

    context 'fail' do
      context 'without policy_agreement' do
        let!(:params) { { party: { name: '老夫子', identify_number: 'F122121211' } } }
        it { expect(subject.perform).to be_falsey }
      end

      context 'id exist' do
        let!(:party) { create(:party) }
        let!(:params) { { party: { name: '老夫子', identify_number: party.identify_number, password: '22222222', password_confirmation: '11111111' } } }
        it { expect(subject.perform).to be_falsey }
      end

      context 'id empty' do
        let!(:params) { { party: { name: '老夫子', identify_number: '', password: '22222222', password_confirmation: '11111111' } } }
        it { expect(subject.perform).to be_falsey }
      end

      context 'name empty' do
        let!(:params) { { party: { name: '', identify_number: 'F122121211', password: '22222222', password_confirmation: '11111111' } } }
        it { expect(subject.perform).to be_falsey }
      end
    end
  end
end
