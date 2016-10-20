require "rails_helper"

RSpec.describe Admin::CrawlerLogsController, type: :request do
  before { signin_user }
  let!(:crawler_log) { create :crawler_log }

  describe "#index" do
    context "render success" do
      before { get "/admin/crawler_histories/#{crawler_log.crawler_history.id}/crawler_logs" }
      it { expect(response).to be_success }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/crawler_histories/#{crawler_log.crawler_history.id}/crawler_logs/#{crawler_log.id}" }
      it { expect(response).to be_success }
    end
  end
end
