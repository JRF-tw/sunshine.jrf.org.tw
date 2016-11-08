require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do
  def response_body
    JSON.parse(response.body)
  end

  describe 'handling RoutingError' do
    subject! { get '/api/courts/55688.json' }

    it { expect(response_body.key?('message')).to be_truthy }
    it { expect(response.status).to eq(404) }
  end
end
