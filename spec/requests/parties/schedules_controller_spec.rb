require "rails_helper"

RSpec.describe Parties::SchedulesController, type: :request do
  let!(:party) { create :party }
  let!(:court) { create :court }
  before { signin_party(party) }

  context "score flow" do
    let!(:story) { create :story, court: court }
    let!(:schedule) { create :schedule, story: story }
    let!(:judge) { create :judge, court: court }

    describe "#new" do
      subject! { get "/party/score/schedules/new" }
      it { expect(response).to be_success }
    end

    describe "#input_info" do
      subject! { get "/party/score/schedules/input_info" }
      it { expect(response).to be_success }
    end

    describe "#check_info" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/party/score/schedules/check_info", schedule_score: params }
      it { expect(response).to be_redirect }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#input_date" do
      subject! { get "/party/score/schedules/input_date" }
      it { expect(response).to be_success }
    end

    describe "#check_date" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false } }
      subject! { post "/party/score/schedules/check_date", schedule_score: params }
      it { expect(response).to be_redirect }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#input_judge" do
      subject! { get "/party/score/schedules/input_judge" }
      it { expect(response).to be_success }
    end

    describe "#check_judge" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name } }
      subject! { post "/party/score/schedules/check_judge", schedule_score: params }
      it { expect(response).to be_redirect }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#create" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/party/score/schedules", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end
  end

  describe "#rule" do
    subject! { get "/party/score/schedules/rule" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    let!(:schedule_score) { create :schedule_score, schedule_rater: party, court_id: court.id }
    subject! { get "/party/score/schedules/#{schedule_score.id}/edit" }

    it { expect(response).to be_success }
  end

  describe "#update" do
    let!(:schedule_score) { create :schedule_score, schedule_rater: party, court_id: court.id }
    let!(:params) { { rating_score: 1, note: "xxxxx", appeal_judge: false } }
    subject! { put "/party/score/schedules/#{schedule_score.id}", schedule_score: params }

    it { expect(response).to be_success }
  end
end
