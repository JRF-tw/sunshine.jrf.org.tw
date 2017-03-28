require 'rails_helper'

RSpec.describe Parties::VerdictsController, type: :request do
  let!(:party) { create :party, :already_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, :with_verdict, court: court }
  let!(:judge) { create :judge, court: court }
  before { signin_party(party) }

  context 'score flow' do
    describe '#new' do
      subject! { get '/party/score/verdicts/new' }
      it { expect(response).to be_success }
    end

    describe '#input_info' do
      subject! { get '/party/score/verdicts/input_info' }
      it { expect(response).to be_success }
    end

    describe '#check_info' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type } }
        subject! { post '/party/score/verdicts/check_info', verdict_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/party/score/verdicts/check_info', verdict_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end

    describe '#create' do
      context 'success' do
        let!(:params) { attributes_for(:verdict_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type) }
        subject! { post '/party/score/verdicts', verdict_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/party/score/verdicts', verdict_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end
  end

  describe '#rule' do
    subject! { get '/party/score/verdicts/rule' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story, court_id: court.id }
    subject! { get "/party/score/verdicts/#{verdict_score.id}/edit" }
    it { expect(response).to be_success }
  end

  describe '#update' do
    let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story, court_id: court.id }
    let!(:params) { attributes_for(:verdict_score_for_update_params) }
    subject! { put "/party/score/verdicts/#{verdict_score.id}", verdict_score: params }
    it { expect(response).to redirect_to('/party/score/verdicts/thanks_scored') }
  end

  describe '#thanks_scored' do
    subject! { get '/party/score/verdicts/thanks_scored' }
    it { expect(response).to be_success }
  end
end
