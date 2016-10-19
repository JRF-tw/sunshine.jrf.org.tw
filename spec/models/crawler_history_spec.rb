require 'rails_helper'

RSpec.describe CrawlerHistory, type: :model do
  let(:crawler_history) { create :crawler_history }

  context "FactoryGirl" do
    context "default" do
      it { expect(crawler_history).not_to be_new_record }
    end
  end
end
