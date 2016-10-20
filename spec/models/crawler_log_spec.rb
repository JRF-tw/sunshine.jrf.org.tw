require "rails_helper"

RSpec.describe CrawlerLog, type: :model do
  let(:crawler_log) { create :crawler_log }

  context "FactoryGirl" do
    context "defualt" do
      it { expect(crawler_log).not_to be_new_record }
    end
  end
end
