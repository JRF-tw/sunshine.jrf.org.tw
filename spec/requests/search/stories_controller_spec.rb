require 'rails_helper'

RSpec.describe Search::StoriesController, type: :request do
  let!(:story) { create :story }

  context '#index' do
    context 'without search query' do
      before { get '/search' }
      it { expect(response).to be_success }
      it { expect(response.body).not_to match(story.word_type) }
    end

    context 'with search query' do
      before { get '/search', q: { year_eq: story.year, number_eq: story.number } }
      it { expect(response).to be_success }
      it { expect(response.body).to match(story.word_type) }
    end
  end

  context '#show' do
    context 'success' do
      let(:url) { URI.encode("/search/#{story.court.code}/#{story.identity}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match(story.word_type) }
    end

    context 'wrong court code' do
      let(:url) { URI.encode("/search/fJU/#{story.identity}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match('該法院代號不存在') }
    end

    context 'wrong story data' do
      let(:url) { URI.encode("/search/#{story.court.code}/#{story.identity + '1'}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match('案件不存在') }
    end
  end
end
