require 'rails_helper'

RSpec.describe Api::StoriesController, type: :request do
  before { host! 'api.example.com' }
  let(:story) { create :story, lawyer_names: ['千鳥', '卍鳥'] }
  let(:court) { story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }

  def info_partial(story)
    {
      identity: {
        type: story.story_type,
        year: story.year,
        word: story.word_type,
        number: story.number
      },
      court: {
        name: story.court.full_name,
        code: story.court.code
      },
      adjudge_date: story.adjudge_date,
      pronounce_date: story.pronounce_date,
      judges_names: story.judges_names,
      prosecutor_names: story.prosecutor_names,
      lawyer_names: story.lawyer_names,
      party_names: story.party_names
    }
  end

  describe '#index' do

    def index_json(stories)
      stories_array = []
      stories.each do |story|
        stories_array << info_partial(story).merge(detail_link: api_story_url(story.court.code, story.identity))
      end
      { stories: stories_array }.deep_stringify_keys
    end

    context 'success' do
      subject! { get '/search/stories', q: { number: story.number } }
      it { expect(response_body).to include(index_json(Story.where(number: story.number))) }
      it { expect(response).to be_success }
    end

    context 'court code not exist' do
      subject! { get '/search/stories', q: { court_code: '5566' } }
      it { expect(response_body['message']).to eq('法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'stories not exist' do
      subject! { get '/search/stories', q: { number: story.number + 1 } }
      it { expect(response_body['stories']).to eq([]) }
      it { expect(response).to be_success }
    end

    context 'query not exist' do
      subject! { get '/search/stories' }
      it { expect(response_body['message']).to eq('尚未輸入查詢條件') }
      it { expect(response.status).to eq(404) }
    end

    context 'has pagination data' do
      def pagination_data
        {
          pagination: {
            current:  1,
            previous_url: nil,
            next_url:     nil,
            per_page: 20,
            pages:    1,
            count:    1
          }
        }.deep_stringify_keys
      end

      subject! { get '/search/stories', q: { number: story.number } }
      it { expect(response_body).to include(pagination_data) }
    end
  end

  describe '#show' do
    def show_json
      { story: info_partial(story) }.deep_stringify_keys
    end

    context 'success' do
      let(:url) { URI.encode("/#{code}/#{story.identity}") }
      subject! { get url }
      it { expect(response_body).to eq(show_json) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.encode("/XxX/#{story.identity}") }
      subject! { get url }
      it { expect(response_body['message']).to eq('法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/#{code}/#{story.identity + '1'}") }
      subject! { get url }
      it { expect(response_body['message']).to eq('查無此案件') }
      it { expect(response.status).to eq(404) }
    end
  end
end
