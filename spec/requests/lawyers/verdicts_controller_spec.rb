require 'rails_helper'

RSpec.describe Lawyers::VerdictsController, type: :request do
  let!(:lawyer) { create :lawyer, :with_confirmed, :with_password }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, :with_verdict, court: court }
  let!(:judge) { create :judge, court: court }
  before { signin_lawyer(lawyer) }

  context 'score flow' do
    describe '#new' do
      subject! { get '/lawyer/score/verdicts/new' }
      it { expect(response).to be_success }
    end

    describe '#input_info' do
      subject! { get '/lawyer/score/verdicts/input_info' }
      it { expect(response).to be_success }
    end

    describe '#check_info' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type } }
        subject! { post '/lawyer/score/verdicts/check_info', verdict_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/verdicts/check_info', verdict_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end

    describe '#create' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name, score_3_1: 1, score_3_2_1: 1, score_3_2_2: 1, score_3_2_3: 1, score_3_2_4: 1, score_3_2_5: 1, score_3_2_6: 1, note: 'xxxxx', appeal_judge: false } }
        subject! { post '/lawyer/score/verdicts', verdict_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/verdicts', verdict_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end
  end

  describe '#rule' do
    subject! { get '/lawyer/score/verdicts/rule' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story, court_id: court.id }
    subject! { get "/lawyer/score/verdicts/#{verdict_score.id}/edit" }
    it { expect(response).to be_success }
  end

  describe '#update' do
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story, court_id: court.id }
    let!(:params) { { score_3_1: 1, score_3_2_1: 1, score_3_2_2: 1, score_3_2_3: 1, score_3_2_4: 1, score_3_2_5: 1, score_3_2_6: 1, note: 'xxxxx', appeal_judge: false } }
    subject! { put "/lawyer/score/verdicts/#{verdict_score.id}", verdict_score: params }
    it { expect(response).to redirect_to('/lawyer/score/verdicts/thanks_scored') }
  end

  describe '#thanks_scored' do
    subject! { get '/lawyer/score/verdicts/thanks_scored' }
    it { expect(response).to be_success }
  end
end
