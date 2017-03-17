require 'rails_helper'

RSpec.describe Api::StoriesController, type: :request do
  before { host! 'api.example.com' }
  let(:story) { create :story, lawyer_names: ['千鳥', '卍鳥'] }
  let(:court) { story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }

  describe '#index' do
    def index_json
      {
        stories: [{
          story_type: story.story_type,
          year: story.year,
          word_type: story.word_type,
          number: story.number,
          adjudge_date: story.adjudge_date,
          pronounce_date: story.pronounce_date,
          court_name: court.full_name,
          court_code: court.code,
          judges_names: story.judges_names,
          prosecutor_names: story.prosecutor_names,
          lawyer_names: story.lawyer_names,
          party_names: story.party_names,
          detail_link: api_story_url(story.court.code, story.identity)
        }]
      }.deep_stringify_keys
    end

    context 'success' do
      subject! { get '/search/stories', number: story.number, lawyer_names_cont: '千鳥' }
      it { expect(response_body).to eq(index_json) }
      it { expect(response).to be_success }
    end

    context 'court code not exist' do
      subject! { get '/search/stories', court_code: '5566' }
      it { expect(response_body['message']).to eq('法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'stories not exist' do
      subject! { get '/search/stories', number: story.number + 1 }
      it { expect(response_body['message']).to eq('查無案件') }
      it { expect(response.status).to eq(404) }
    end

    context 'query not exist' do
      subject! { get '/search/stories' }
      it { expect(response_body['message']).to eq('尚未輸入查詢條件') }
      it { expect(response.status).to eq(404) }
    end
  end

  describe '#show' do
    def show_json
      {
        story: {
          story_type: story.story_type,
          year: story.year,
          word_type: story.word_type,
          number: story.number,
          adjudge_date: story.adjudge_date,
          pronounce_date: story.pronounce_date,
          court_name: court.full_name,
          court_code: court.code,
          judges_names: story.judges_names,
          prosecutor_names: story.prosecutor_names,
          lawyer_names: story.lawyer_names,
          party_names: story.party_names
        }
      }.deep_stringify_keys
    end
    context 'success' do
      let(:url) { URI.encode("/#{code}/#{year}-#{word_type}-#{number}") }
      subject! { get url }
      it { expect(response_body).to eq(show_json) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.encode("/XxX/#{year}-#{word_type}-#{number}") }
      subject! { get url }
      it { expect(response_body['message']).to eq('法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/#{code}/#{year}-假字號-#{number}") }
      subject! { get url }
      it { expect(response_body['message']).to eq('查無此案件') }
      it { expect(response.status).to eq(404) }
    end
  end
end
