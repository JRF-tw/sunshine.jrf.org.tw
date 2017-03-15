require 'rails_helper'

RSpec.describe Api::VerdictsController, type: :request do
  include_context 'create_verdict_data_for_api'
  before { host! 'api.example.com' }

  describe '#show' do
    context 'success' do
      let(:url) { URI.parse(URI.encode("/#{code}-#{year}-#{word_type}-#{number}/verdict")) }
      subject! { get url }
      it { expect(response_body['verdict']['court_code']).to eq(code) }
      it { expect(response_body['verdict']['court_name']).to eq(court.full_name) }
      it { expect(response_body['verdict']['body']['verdict_file_url']).to eq(verdict.file.url) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.parse(URI.encode('/TPD-105-黑媽媽-123/verdict')) }
      subject! { get url }
      it { expect(response_body['message']).to eq('該法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.parse(URI.encode("/#{code}-105-黑媽媽-123/verdict")) }
      subject! { get url }
      it { expect(response_body['message']).to eq('案件不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'verdict not exist' do
      before { Verdict.destroy_all }
      let(:url) { URI.parse(URI.encode("/#{code}-#{year}-#{word_type}-#{number}/verdict")) }
      subject! { get url }
      it { expect(response_body['message']).to eq('此案件尚未有判決書') }
      it { expect(response.status).to eq(404) }
    end
  end
end
