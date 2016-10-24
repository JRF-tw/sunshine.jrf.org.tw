require 'rails_helper'

describe Party::UpdateProfileContext do
  let!(:party) { create :party }
  let!(:context) { described_class.new(party) }

  context 'success' do
    let!(:params) { { name: 'xxxxxxx' } }
    subject { described_class.new(party).perform(params) }

    it { expect(subject).to be_truthy }
    it { expect { subject }.to change { party.reload.name } }
  end
end
