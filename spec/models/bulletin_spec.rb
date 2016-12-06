require 'rails_helper'

RSpec.describe Bulletin, type: :model do
  let!(:bulletin) { create :bulletin }

  it 'FactoryGirl' do
    expect(bulletin).not_to be_new_record
  end

  describe '#can_be_banner' do
    context 'true' do
      let!(:bulletin) { create :bulletin, :with_pic }
      it { expect(bulletin.can_be_banner?).to be_truthy }
    end

    context 'false' do
      it { expect(bulletin.can_be_banner?).to be_falsey }
    end
  end
end
