require 'rails_helper'

RSpec.describe Scrap::ParseRefereeContext, type: :model do
  let!(:court) { create :court, code: 'TPH', scrap_name: '臺灣高等法院' }
  let!(:scrap_id) { '1' }
  let!(:type) { 'V' }
  let!(:start_date) { Time.zone.today.strftime('%Y%m%d') }
  let!(:end_date) { Time.zone.today.strftime('%Y%m%d') }

  describe '#perform' do
    context 'verdict' do
      subject { described_class.new(court: court, scrap_id: scrap_id, type: type, start_date: start_date, end_date: end_date).perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportVerdictContext, :perform, queue: 'import_referee') }
    end

    context 'rule' do
      before { webmock_ruling }
      subject { described_class.new(court: court, scrap_id: scrap_id, type: type, start_date: start_date, end_date: end_date).perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportRuleContext, :perform, queue: 'import_referee') }
    end
  end
end
