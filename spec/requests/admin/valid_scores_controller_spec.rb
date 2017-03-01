require 'rails_helper'

RSpec.describe Admin::ValidScoresController do
  before { signin_user }
  let!(:schedule_valid_score) { create :valid_score }
  let!(:verdict_valid_score) { create :valid_score, :with_verdict_score }

  describe '#index' do
    context 'search the stroy id' do
      before { get '/admin/valid_scores', q: { story_id_eq: schedule_valid_score.story_id } }
      it { expect(response.body).to match(schedule_valid_score.story.identity) }
    end

    context 'search the rater' do
      before {
        get '/admin/valid_scores', q: {
          score_rater_type_eq: verdict_valid_score.score_rater_type,
          score_rater_id_eq: verdict_valid_score.score_rater_id
        }
      }
      it { expect(response.body).to match(verdict_valid_score.story.identity) }
    end

    context 'search the judge id' do
      before { get '/admin/valid_scores', q: { judge_id_eq: schedule_valid_score.judge_id } }
      it { expect(response.body).to match(schedule_valid_score.story.identity) }
    end
  end

  describe '#show' do
    before { get "/admin/valid_scores/#{verdict_valid_score.id}" }
    it { expect(response).to be_success }
  end
end
