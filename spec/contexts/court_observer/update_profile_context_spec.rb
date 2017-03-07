require 'rails_helper'

describe CourtObserver::UpdateProfileContext do
  let!(:court_observer) { create :court_observer }
  let!(:context) { described_class.new(court_observer) }

  context '#perform' do
    context 'success' do
      let!(:params) { { phone_number: '0911111111' } }
      subject { described_class.new(court_observer).perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { court_observer.reload.phone_number } }
    end

    context 'blank phone_number' do
      let!(:params) { { phone_number: '' } }
      subject { described_class.new(court_observer).perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { court_observer.reload.phone_number } }
    end
  end
end
