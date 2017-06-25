require 'rails_helper'

RSpec.describe Api::CourtsController, type: :request do
  let!(:court) { create :court }
  before { host! 'api.example.com' }
  def response_body
    JSON.parse(response.body)
  end
  describe '#index' do
    context 'success' do
      subject! { get '/courts.json' }
      it { expect(response_body['courts'][0].key?('name')).to be_truthy }
      it { expect(response).to be_success }
    end
  end

  describe '#show' do
    context 'success' do
      subject! { get "/courts/#{court.code}.json" }
      it { expect(response_body['court'].key?('name')).to be_truthy }
      it { expect(response).to be_success }
    end

    context 'not exist id' do
      subject! { get '/courts/55688.json' }
      it { expect(response_body.key?('message')).to be_truthy }
      it { expect(response.status).to eq(404) }
    end
  end
end
