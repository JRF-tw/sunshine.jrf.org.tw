require 'rails_helper'

RSpec.describe BulletinsController, type: :request do
  let!(:bulletin) { create :bulletin }

  describe '#index' do
    before { get '/bulletins' }
    it { expect(response).to be_success }
  end

  describe '#show' do
    before { get "/bulletins/#{bulletin.id}" }
    it { expect(response).to be_success }
  end
end
