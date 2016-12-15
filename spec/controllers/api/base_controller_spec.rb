require 'rails_helper'

RSpec.describe Api::BaseController, type: :controller do
  controller do
    def index
      raise Exception, 'something wrong'
    end

    def show
      raise ActiveRecord::RecordNotFound, 'Couldn t find Court with id=55688'
    end
  end

  def response_body
    JSON.parse(response.body)
  end

  describe 'rescue  RecordNotFound' do
    subject! { get :show, id: 55_688 }

    it { expect(response_body.key?('message')).to be_truthy }
    it { expect(response.status).to eq(404) }
  end

  describe 'handling Exception' do
    subject! { get :index }

    it { expect(response_body.key?('message')).to be_truthy }
    it { expect(response.status).to eq(500) }
  end
end
