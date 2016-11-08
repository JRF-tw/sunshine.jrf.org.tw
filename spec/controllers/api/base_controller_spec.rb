require 'rails_helper'

RSpec.describe Api::BaseController, type: :controller do
  controller do
    def index
      raise ActionController::RoutingError, 'No route matches /xxxx'
    end

    def create
      raise Exception, 'something wrong'
    end
  end

  def response_body
    JSON.parse(response.body)
  end

  describe 'handling RoutingError' do
    subject! { get :index }

    it { expect(response_body.key?('message')).to be_truthy }
    it { expect(response.status).to eq(404) }
  end

  describe 'handling OtherError' do
    subject! { get :create }

    it { expect(response_body.key?('message')).to be_truthy }
    it { expect(response.status).to eq(500) }
  end
end
