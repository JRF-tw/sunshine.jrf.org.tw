require 'rails_helper'

describe Party::DeleteUnconfirmContext do
  let!(:party) { create :party }
  subject { described_class.delete_unconfirm_party(party) }

  context 'success delete' do
    it { expect { subject }.to change { Party.count }.by(-1) }
  end

  context 'not delete if confirmed' do
    let!(:party) { create :party, :already_confirmed }
    it { expect { subject }.not_to change { Party.count } }
  end
end
