require 'rails_helper'

RSpec.describe Api::VerdictsController, type: :request do
  include_context 'create_data_for_request'
  let!(:verdict) { create :verdict, :with_original_url, :with_file, story: story }
  before { host! 'api.example.com' }

  describe '#show' do

    def show_json
      {
        verdict: {
          story: {
            identity: {
              type: story.story_type,
              year: story.year,
              word: story.word_type,
              number: story.number
            },
            reason: story.reason,
            adjudged_on: story.adjudged_on,
            pronounced_on: story.pronounced_on,
            judges_names: story.judges_names,
            lawyer_names: story.lawyer_names,
            prosecutor_names: story.prosecutor_names,
            party_names: story.party_names,
            detail_url: api_story_url(story.court.code, story.identity)
          },
          court: {
            name: court.full_name,
            code: court.code
          },
          reason: verdict.reason,
          judges_names: verdict.judges_names,
          prosecutor_names: verdict.prosecutor_names,
          lawyer_names: verdict.lawyer_names,
          party_names: verdict.party_names,
          adjudged_on: verdict.adjudged_on,
          original_url: verdict.original_url,
          body: {
            raw_html_url: verdict.file.url ? 'https:' + verdict.file.url : nil,
            content_url: verdict.content_file.url ? 'https:' + verdict.content_file.url : nil
          }
        }
      }.deep_stringify_keys
    end

    context 'success' do
      let(:url) { URI.encode("/#{code}/#{story.identity}/verdict") }
      subject! { get url }
      it { expect(response_body).to eq(show_json) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.encode("/XxX/#{story.identity}/verdict") }
      subject! { get url }
      it { expect(response_body['message']).to eq('該法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/#{code}/#{story.identity + '1'}/verdict") }
      subject! { get url }
      it { expect(response_body['message']).to eq('案件不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'verdict not exist' do
      before { Verdict.destroy_all }
      let(:url) { URI.encode("/#{code}/#{story.identity}/verdict") }
      subject! { get url }
      it { expect(response_body['message']).to eq('此案件尚未有判決書') }
      it { expect(response.status).to eq(404) }
    end
  end
end
