require 'rails_helper'

RSpec.describe Api::CourtsController, type: :request do

  describe '#index' do
    context 'success' do
      subject! { get '/api/courts.json' }
      it { expect(response).to be_success }
    end

    context 'undefined route' do
      subject! { get '/api/courts/hihi.json' }
      it { expect(response.body).to match('No route matches /courts/hihi') }
    end
  end

end
