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
end
