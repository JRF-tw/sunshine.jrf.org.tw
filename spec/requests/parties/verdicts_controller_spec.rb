require "rails_helper"

RSpec.describe Parties::VerdictsController, type: :request do
  let!(:party) { create :party }
  before { signin_party }

  context "score flow" do
    let!(:party) { create :party }
    let!(:court) { create :court }
    let!(:story) { create :story, :pronounced, :adjudged, court: court }
    let!(:judge) { create :judge, court: court }

    describe "#new" do
      subject! { get "/party/score/verdicts/new" }
      it { expect(response).to be_success }
    end

    describe "#checked_info" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/party/score/verdicts/checked_info", verdict_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_judge" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name } }
      subject! { post "/party/score/verdicts/checked_judge", verdict_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#create" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/party/score/verdicts", verdict_score: params }
      it { expect(response).to be_redirect }
      it { expect(flash[:error]).to be_nil }
    end
  end

  describe "#rule" do
    subject! { get "/party/score/verdicts/rule" }
    it { expect(response).to be_success }
  end
end
