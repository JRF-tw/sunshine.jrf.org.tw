require 'rails_helper'

RSpec.describe Scrap::NotifyDailyContext, type: :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", scrap_name: "臺灣高等法院" }

  describe "#perform" do
    let!(:interval_object) { Redis::Value.new("daily_scrap_court_intervel") }
    let!(:count_object) { Redis::Counter.new("daily_scrap_court_count") }
    before { interval_object.value = "#{Time.zone.today} ~ #{Time.zone.today}" }
    before { count_object.increment }

    context "court daily report" do
      subject { described_class.new.perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "cleanup_redis_date" do
      subject! { described_class.new.perform }

      it { expect(interval_object.value).to be_nil }
      it { expect(count_object.value).to eq(0) }
    end
  end
end
