require 'rails_helper'

RSpec.describe Api::CourtsController, type: :request do
  let!(:court) { create :court }
  def response_body
    JSON.parse(response.body)
  end
  describe '#index' do
    context 'success' do
      subject! { get '/api/courts.json' }
      it { expect(response_body['courts'][0].key?('full_name')).to be_truthy }
      it { expect(response).to be_success }
    end
  end

  describe '#show' do
    context 'success' do
      subject! { get "/api/courts/#{court.id}.json" }
      it { expect(response_body.key?('full_name')).to be_truthy }
      it { expect(response).to be_success }
    end

    context 'not exist id' do
      subject! { get '/api/courts/55688.json' }
      it { expect(response_body.key?('message')).to be_truthy }
      it { expect(response.status).to eq(404) }
    end
  end
end
