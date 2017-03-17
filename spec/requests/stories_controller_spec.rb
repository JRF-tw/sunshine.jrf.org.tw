require 'rails_helper'

RSpec.describe StoriesController, type: :request do
  let!(:story) { create :story }

  context '#index' do
    context 'without search query' do
      before { get '/stories' }
      it { expect(response).to be_success }
      it { expect(response.body).not_to match(story.word_type) }
    end

    context 'with search query' do
      before { get '/stories', q: { year_eq: story.year, number_eq: story.number } }
      it { expect(response).to be_success }
      it { expect(response.body).to match(story.word_type) }
    end
  end

  context '#show' do
    context 'success' do
      let(:url) { URI.encode("/#{story.court.code}/#{story.year}-#{story.word_type}-#{story.number}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match(story.word_type) }
    end

    context 'wrong court code' do
      let(:url) { URI.encode("/fJU/#{story.year}-#{story.word_type}-#{story.number}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match('法院代號不存在') }
    end

    context 'wrong story data' do
      let(:url) { URI.encode("/#{story.court.code}/#{story.year}-假字號-#{story.number}") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match('查無此案件') }
    end
  end
end
