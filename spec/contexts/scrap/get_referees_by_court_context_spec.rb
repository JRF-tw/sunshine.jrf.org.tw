require 'rails_helper'

RSpec.describe Scrap::GetRefereesByCourtContext, type: :model do
  let!(:court) { create :court, code: 'TPH' }
  let!(:start_date) { Time.zone.today }
  let!(:end_date) { Time.zone.today }

  describe '#perform' do
    subject { described_class.new(court, start_date, end_date).perform }

    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetRefereesTotalResultContext, :perform, queue: 'crawler_referee') }
  end
end
