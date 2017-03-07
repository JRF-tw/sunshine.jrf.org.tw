require 'rails_helper'

RSpec.describe Scrap::ParseVerdictContext, type: :model do
  let!(:court) { create :court, code: 'TPH', scrap_name: '臺灣高等法院' }
  let!(:scrap_id) { '1' }
  let!(:type) { 'V' }
  let!(:start_date) { Time.zone.today.strftime('%Y%m%d') }
  let!(:end_date) { Time.zone.today.strftime('%Y%m%d') }

  describe '#perform' do
    context 'verdict' do
      subject { described_class.new(court, scrap_id, type, start_date, end_date).perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportVerdictContext, :perform, queue: 'crawler_verdict') }
    end

    context 'rule' do
      before {
        stub_request(:get, /http:\/\/jirs\.judicial\.gov\.tw\/FJUD\/FJUDQRY03_1\.aspx/)
          .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling.html"))
      }
      subject { described_class.new(court, scrap_id, type, start_date, end_date).perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportRuleContext, :perform, queue: 'crawler_verdict') }
    end
  end
end
