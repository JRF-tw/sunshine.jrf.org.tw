require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do
  before { host! 'api.example.com' }

  def response_body
    JSON.parse(response.body)
  end

  describe '#index' do
    context 'success' do
      subject! { get '/' }
      it { expect(response_body['status']).to eq('active') }
      it { expect(response).to be_success }
    end
  end
end
