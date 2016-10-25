require 'rails_helper'

RSpec.describe Api::CourtsController, type: :request do
  let!(:court) { create :court }
  def response_body
    JSON.parse(response.body)
  end
  describe '#index' do
    context 'success' do
      subject! { get '/api/courts.json' }
      it { expect(response_body[0].key?('full_name')).to be_truthy }
      it { expect(response).to be_success }
    end
  end

  describe '#show' do
    context 'success' do
      subject! { get "/api/courts/#{court.id}.json" }
      it { expect(response_body['full_name']).to eq(court.full_name) }
      it { expect(response).to be_success }
    end

    context 'not exist id' do
      subject! { get '/api/courts/55688.json' }
      it { expect(response_body['message']).to eq('法院id不存在') }
      it { expect(response.status).to eq(404) }
    end
  end
end
