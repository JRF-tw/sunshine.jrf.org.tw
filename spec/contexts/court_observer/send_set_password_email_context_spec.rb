require 'rails_helper'

describe CourtObserver::SendSetPasswordEmailContext do

  describe 'perform' do
    context 'success' do
      let!(:court_observer) { create :court_observer }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
