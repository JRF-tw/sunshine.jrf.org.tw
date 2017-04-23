require 'rails_helper'

RSpec.describe Search::VerdictsController, type: :request do
  include_context 'create_data_for_request'
  let!(:verdict) { create :verdict, story: story }

  describe '#show' do
    context 'success' do
      let(:url) { URI.encode("/search/#{code}/#{story.identity}/verdict") }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match(verdict.reason) }
    end

    context 'verdict not exist' do
      let(:url) { URI.encode("/search/#{code}/#{story.identity}/verdict") }
      before { Verdict.destroy_all }
      before { get url }
      it { expect(response).to be_success }
      it { expect(response.body).to match('尚未有判決書') }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/search/#{code}/#{story.identity + '1'}/verdict") }
      before { get url }
      it { expect(response).to redirect_to('/search') }
      it { expect(flash[:error]).to eq('案件不存在') }
    end
  end
end
