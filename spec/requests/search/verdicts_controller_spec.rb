require 'rails_helper'

RSpec.describe Search::VerdictsController, type: :request do
  before { host! 'search.example.com' }
  include_context 'create_data_for_request'
  let!(:verdict) { create :verdict }

  describe '#show' do
    let(:url) { URI.encode("/#{code}/#{story.identity}/verdict") }
    before { get url }
    it { expect(response).to be_success }
  end
end
