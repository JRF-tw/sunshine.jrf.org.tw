require 'rails_helper'

RSpec.describe Api::RulesController, type: :request do
  include_context 'create_data_for_request'
  let!(:rule) { create :rule, :with_original_url, story: story }
  before { host! 'api.example.com' }
  def index_json
    {
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
      court: court_body(court),
      rules: [{
        reason: rule.reason,
        judges_names: rule.judges_names,
        prosecutor_names: rule.prosecutor_names,
        lawyer_names: rule.lawyer_names,
        party_names: rule.party_names,
        adjudged_on: rule.adjudged_on,
        original_url: rule.original_url,
        body: {
          raw_html_url: rule.file.url ? 'https:' + rule.file.url : nil,
          content_url: rule.content_file.url ? 'https:' + rule.content_file.url : nil
        }
      }]
    }.deep_stringify_keys
  end
  describe '#index' do
    context 'success' do
      let(:url) { URI.encode("/#{code}/#{story.identity}/rules") }
      subject! { get url }
      it { expect(response_body).to eq(index_json) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.encode("/XxX/#{story.identity}/rules") }
      subject! { get url }
      it { expect(response_body['message']).to eq('該法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/#{code}/#{story.identity + '1'}/rules") }
      subject! { get url }
      it { expect(response_body['message']).to eq('案件不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'rule not exist' do
      before { Rule.destroy_all }
      let(:url) { URI.encode("/#{code}/#{story.identity}/rules") }
      subject! { get url }
      it { expect(response_body['message']).to eq('此案件尚未有裁決書') }
      it { expect(response.status).to eq(404) }
    end
  end
end
