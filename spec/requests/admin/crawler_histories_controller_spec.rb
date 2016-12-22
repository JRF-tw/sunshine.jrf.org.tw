require 'rails_helper'

RSpec.describe Admin::CrawlerHistoriesController, type: :request do
  before { signin_user }
  let!(:crawler_history) { create :crawler_history }

  describe '#index' do
    context 'render success' do
      before { get '/admin/crawler_histories' }
      it { expect(response).to be_success }
    end
  end

  describe '#status' do
    context 'render success' do
      before { get '/admin/crawler_histories/status' }
      it { expect(response).to be_success }
    end
  end

  describe '#index' do
    context 'render success' do
      before { get '/admin/crawler_histories/highest_judges' }
      it { expect(response).to be_success }
    end
  end
end
