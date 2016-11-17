require 'rails_helper'

RSpec.describe BulletinsController, type: :request do

  describe '#index' do
    before { get '/bulletins' }
    it { expect(response).to be_success }
  end

  describe '#show' do
    before { get '/bulletins/1' }
    it { expect(response).to be_success }
  end
end
