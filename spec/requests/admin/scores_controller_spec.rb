require 'rails_helper'

RSpec.describe Admin::ScoresController do
  before { signin_user }
  let!(:verdict_score) { create :verdict_score, :by_party }
  let!(:schedule_score) { create :schedule_score }

  describe '#index' do
    context 'search the stroy id' do
      before { get '/admin/scores', q: { story_id_eq: schedule_score.story_id } }
      it {
        expect(response.body).to match(schedule_score.story.identity)
        expect(assigns(:scores).first.id).to eq schedule_score.id
      }
    end

    context 'search the rater' do
      before {
        get '/admin/scores', q: {
          schedule_rater_type_eq: verdict_score.verdict_rater_type,
          schedule_rater_id_eq: verdict_score.verdict_rater_id
        }
      }
      it {
        expect(response.body).to match(verdict_score.story.identity)
        expect(assigns(:scores).first.id).to eq verdict_score.id
      }
    end

    context 'search the judge id' do
      before { get '/admin/scores', q: { judge_id_eq: schedule_score.judge_id } }
      it {
        expect(response.body).to match(schedule_score.story.identity)
        expect(assigns(:scores).first.id).to eq schedule_score.id
      }
    end
  end

  describe '#show' do
    context 'ss_show' do
      before { get "/admin/scores/#{schedule_score.id}/ss_show" }
      it { expect(response).to be_success }
    end

    context 'vs_show' do
      before { get "/admin/scores/#{verdict_score.id}/vs_show" }
      it { expect(response).to be_success }
    end
  end
end
