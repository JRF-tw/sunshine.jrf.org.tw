require "rails_helper"

describe Party::CheckScheduleScoreDateContext do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, start_on: schedule.start_on, confirmed_realdate: false } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
    end

    context "date nil" do
      before { params[:start_on] = nil }
      it { expect(subject).to be_falsey }
    end

    context "date empty" do
      before { params[:start_on] = "" }
      it { expect(subject).to be_falsey }
    end

    context "date in future" do
      before { params[:start_on] = Time.zone.today + 1.day }
      it { expect(subject).to be_falsey }
    end

    context "story not found" do
      before { params[:word_type] = "xx" }
      it { expect(subject).to be_falsey }
    end

    context "schedule not found" do
      before { params[:start_on] = schedule.start_on - 1.day }
      it { expect(subject).to be_falsey }
    end

    context "schedule not found" do
      before { params[:start_on] = schedule.start_on - 1.day }
      it { expect(subject).to be_falsey }
    end

    context "not in score time intervel" do
      before { schedule.update_attributes(start_on: Time.zone.today - 15.days) }
      it { expect(subject).to be_falsey }
    end
  end

  context "report realdate" do
    subject { described_class.new(party).perform(params) }
    before { params[:confirmed_realdate] = "true" }

    context "diff date" do
      before { params[:start_on] = schedule.start_on - 14.days }
      it { expect(subject).to be_nil }
    end

    context "should alert slack over MAX_REPORT_TIME " do
      before { params[:start_on] = schedule.start_on - 14.days }
      before { party.score_report_schedule_real_date.value = 4 }

      it { expect { subject }.to change { party.score_report_schedule_real_date.value } }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
