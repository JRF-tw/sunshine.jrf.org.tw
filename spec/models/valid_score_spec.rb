require 'rails_helper'

RSpec.describe ValidScore do
  let(:valid_score) { create :valid_score }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { valid_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
