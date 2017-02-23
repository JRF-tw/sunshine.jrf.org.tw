require 'rails_helper'

RSpec.describe Admin::ScoresController do
  before { signin_user }
  let!(:verdict_score) { create :verdict_score, :by_party }
  let!(:schedule_score) { create :schedule_score }

  describe '#index' do
    context 'search the stroy id' do
      before { get '/admin/scores', score_search_form_object: { story_id_eq: schedule_score.story_id } }
      it { expect(response.body).to match(schedule_score.story.identity) }
      it { expect(assigns(:scores).first.id).to eq schedule_score.id }
    end

    context 'search the rater' do
      before {
        get '/admin/scores', score_search_form_object: {
          rater_type_eq: verdict_score.verdict_rater_type,
          rater_id_eq: verdict_score.verdict_rater_id
        }
      }
      it { expect(response.body).to match(verdict_score.story.identity) }
      it { expect(assigns(:scores).first.id).to eq verdict_score.id }
    end

    context 'search the judge id' do
      before { get '/admin/scores', score_search_form_object: { judge_id_eq: schedule_score.judge_id } }
      it { expect(response.body).to match(schedule_score.story.identity) }
      it { expect(assigns(:scores).first.id).to eq schedule_score.id }
    end
  end

  describe '#show' do
    context 'schedule' do
      before { get "/admin/scores/#{schedule_score.id}/schedule" }
      it { expect(response).to be_success }
    end

    context '#verdict' do
      before { get "/admin/scores/#{verdict_score.id}/verdict" }
      it { expect(response).to be_success }
    end
  end
end
