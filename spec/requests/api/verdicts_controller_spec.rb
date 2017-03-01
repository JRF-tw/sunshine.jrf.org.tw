require 'rails_helper'

RSpec.describe Api::VerdictsController, type: :request do
  let!(:verdict) { create :verdict, :with_file }
  let(:story) { verdict.story }
  let(:court) { verdict.story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }
  before { host! 'api.example.com' }

  def response_body
    JSON.parse(response.body)
  end

  describe '#show' do
    context 'success' do
      let(:url) { URI.parse(URI.encode("/#{code}-#{year}-#{word_type}-#{number}/verdict")) }
      subject! { get url }
      it { expect(response_body['verdicts'][0]['法院代號']).to eq(code) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.parse(URI.encode('/TPD-105-黑媽媽-123/verdict')) }
      subject! { get url }
      it { expect(response_body['errors']).to eq('該法院不存在') }
    end

    context 'story not exist' do
      let(:url) { URI.parse(URI.encode("/#{code}-105-黑媽媽-123/verdict")) }
      subject! { get url }
      it { expect(response_body['errors']).to eq('此案件不存在') }
    end

    context 'verdicts not exist' do
      before { Verdict.destroy_all }
      let(:url) { URI.parse(URI.encode("/#{code}-#{year}-#{word_type}-#{number}/verdict")) }
      subject! { get url }
      it { expect(response_body['messages']).to eq('此案件尚未有判決書') }
    end
  end
end
