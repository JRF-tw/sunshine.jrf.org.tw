require 'rails_helper'

RSpec.describe Api::VerdictsController, type: :request do
  include_context 'create_data_for_request'
  let!(:verdict) { create :verdict, story: story }
  before { host! 'api.example.com' }

  describe '#show' do

    def show_json
      {
        verdict: {
          story_identity: {
            type: story.story_type,
            year: story.year,
            word: story.word_type,
            number: story.number
          },
          court: {
            name: court.full_name,
            code: court.code
          },
          summary: verdict.summary,
          date: verdict.date,
          judges_names: verdict.judges_names,
          prosecutor_names: verdict.prosecutor_names,
          lawyer_names: verdict.lawyer_names,
          party_names: verdict.party_names,
          related_story: verdict.related_story,
          publish_on: verdict.publish_on,
          body: {
            verdict_file_url: verdict.file.url,
            verdict_content_url: verdict.content_file.url
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
