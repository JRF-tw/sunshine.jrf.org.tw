require "rails_helper"

RSpec.describe Parties::SchedulesController, type: :request do
  let!(:party) { create :party }
  before { signin_party(party) }

  context "score flow" do
    let!(:court) { create :court }
    let!(:story) { create :story, court: court }
    let!(:schedule) { create :schedule, story: story }
    let!(:judge) { create :judge, court: court }

    describe "#new" do
      subject! { get "/party/score/schedules/new" }
      it { expect(response).to be_success }
    end

    describe "#checked_info" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/party/score/schedules/checked_info", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_date" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false } }
      subject! { post "/party/score/schedules/checked_date", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#checked_judge" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name } }
      subject! { post "/party/score/schedules/checked_judge", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end

    describe "#create" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/party/score/schedules", schedule_score: params }
      it { expect(response).to be_success }
      it { expect(flash[:error]).to be_nil }
    end
  end

  describe "#rule" do
    subject! { get "/party/score/schedules/rule" }
    it { expect(response).to be_success }
  end
end
