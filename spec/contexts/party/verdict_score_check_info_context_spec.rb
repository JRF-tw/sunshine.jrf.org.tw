require "rails_helper"

describe Party::VerdictScoreCheckInfoContext do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
    end

    context "court id invalid" do
      before { params[:court_id] = court.id + 1 }
      it { expect(subject).to be_falsey }
    end

    context "year empty" do
      before { params[:year] = "" }
      it { expect(subject).to be_falsey }
    end

    context "word_type empty" do
      before { params[:word_type] = "" }
      it { expect(subject).to be_falsey }
    end

    context "number empty" do
      before { params[:number] = "" }
      it { expect(subject).to be_falsey }
    end

    context "wrong info not found story" do
      before { params[:word_type] = "xxx" }
      it { expect(subject).to be_falsey }
    end

    context "story not adjudge" do
      context "adjudge " do
        before { story.update_attributes(is_adjudge: true) }
        it { expect(subject).to be_truthy }
      end

      context "not adjudge" do
        before { story.update_attributes(is_adjudge: false) }
        it { expect(subject).to be_falsey }
      end
    end

    context "valid_score_intervel" do
      context "out score intervel" do
        before { story.update_attributes(adjudge_date: Time.zone.today - 91.days) }
        it { expect(subject).to be_falsey }
      end

      context "in score intervel" do
        before { story.update_attributes(adjudge_date: Time.zone.today - 31.days) }
        it { expect(subject).to be_truthy }
      end
    end
  end
end
