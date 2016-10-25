require 'rails_helper'

RSpec.describe Api::CourtsController, type: :request do

  describe '#index' do
    let!(:court) { create :court }
    def response_body
      JSON.parse(response.body)
    end

    context 'success' do
      subject! { get '/api/courts.json' }
      it { expect(response_body[0]['full_name']).to match(court.full_name) }
      it { expect(response.status).to eq 200 }
    end

    context 'undefined route' do
      subject! { get '/api/courts/hihi.json' }
      it { expect(response.body).to match('No route matches /courts/hihi') }
    end
  end

end
