require "rails_helper"

RSpec.describe Lawyers::VerdictsController, type: :request do
  let!(:lawyer) { create :lawyer, :with_confirmed, :with_password }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  before { signin_lawyer(lawyer) }

  context "score flow" do
    describe "#new" do
      subject! { get "/lawyer/score/verdicts/new" }
      it { expect(response).to be_success }
    end

    describe "#checked_info" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_judge" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name } }
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#create" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/lawyer/score/verdicts", verdict_score: params }
      it { expect(response).to be_redirect }
      it { expect(flash[:error]).to be_nil }
    end
  end

  describe "#rule" do
    subject! { get "/lawyer/score/verdicts/rule" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story, court_id: court.id }
    subject! { get "/lawyer/score/verdicts/#{verdict_score.id}/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story, court_id: court.id }
    let!(:params) { { quality_score: 5, note: "xxxxx", appeal_judge: false } }
    subject! { put "/lawyer/score/verdicts/#{verdict_score.id}", verdict_score: params }
    it { expect(response).to redirect_to("/lawyer/score/verdicts/thanks_scored") }
  end

  describe "#thanks_scored" do
    subject! { get "/lawyer/score/verdicts/thanks_scored" }
    it { expect(response).to be_success }
  end
end
