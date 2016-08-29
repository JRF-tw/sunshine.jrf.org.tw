require "rails_helper"

RSpec.describe CourtObservers::SchedulesController, type: :request do
  let!(:court_observer) { create :court_observer }
  let!(:court) { create :court }
  before { signin_court_observer(court_observer) }

  context "score flow" do
    let!(:story) { create :story, court: court }
    let!(:schedule) { create :schedule, story: story }
    let!(:judge) { create :judge, court: court }

    describe "#new" do
      subject! { get "/observer/score/schedules/new" }
      it { expect(response).to be_success }
    end

    describe "#checked_info" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/observer/score/schedules/checked_info", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_date" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.start_on, confirmed_realdate: false } }
      subject! { post "/observer/score/schedules/checked_date", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_judge" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.start_on, confirmed_realdate: false, judge_name: judge.name } }
      subject! { post "/observer/score/schedules/checked_judge", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#create" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/observer/score/schedules", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end
  end

  describe "#rule" do
    subject! { get "/observer/score/schedules/rule" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, court_id: court.id }
    subject! { get "/observer/score/schedules/#{schedule_score.id}/edit" }

    it { expect(response).to be_success }
  end

  describe "#update" do
    let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, court_id: court.id }
    let!(:params) { { rating_score: 1, note: "xxxxx", appeal_judge: false } }
    subject! { put "/observer/score/schedules/#{schedule_score.id}", schedule_score: params }

    it { expect(response).to be_success }
  end
end
