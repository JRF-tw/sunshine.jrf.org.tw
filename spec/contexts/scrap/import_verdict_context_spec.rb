require 'rails_helper'

RSpec.describe Scrap::ImportVerdictContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }
  let!(:judge) { FactoryGirl.create :judge, name: "施俊堯" }
  let!(:branch) { FactoryGirl.create :branch, court: court, judge: judge, chamber_name: "臺灣高等法院刑事庭"}
  let!(:import_data) { Mechanize.new.get(Scrap::GetVerdictsContext::VERDICT_URI) }

  describe "#perform" do
    subject{ described_class.new(import_data, court).perform }

    context "create verdict" do
      it { expect{ subject }.to change{ Verdict.last } }
    end

    context "get main_judge" do
      it { expect(subject.main_judge).to eq(judge) }
    end

    context "find_or_create_story" do
      context "create" do
        it { expect{ subject }.to change{ Story.count } }
      end

      context "find" do
        before { subject }
        it { expect{ subject }.not_to change{ Story.count } }
      end
    end

    context "upload file to s3" do
      it { expect(subject.file).to be_present }
    end

    context "update data to story" do
      before { subject }
      context "sync names" do
        it { expect(subject.judges_names).to eq(subject.story.judges_names) }
        it { expect(subject.prosecutor_names).to eq(subject.story.prosecutor_names) }
        it { expect(subject.defendant_names).to eq(subject.story.defendant_names) }
        it { expect(subject.lawyer_names).to eq(subject.story.lawyer_names) }
      end

      context "sync main jugde info" do
        it { expect(subject.story.main_judge).to be_present }
      end

      context "sync is adjudge to story" do
        it { expect(subject.story.is_adjudge).to be_truthy }
      end
    end

    context "update adjudge date" do
      context "story unexist adjudge_date" do
        it { expect(subject.story.adjudge_date).to be_truthy }
        it { expect(subject.adjudge_date).to be_truthy }
      end

      context "story exist adjudge_date" do
        before { subject.story.update_attributes(adjudge_date: Date.today - 1.days) }

        it { expect { subject }.not_to change { subject.story.adjudge_date } }
      end
    end

    context "create judge_verdicts" do
      let!(:judge) { FactoryGirl.create :judge, name: "李麗珠" }
      let!(:branch) { FactoryGirl.create :branch, court: court, judge: judge, chamber_name: "臺灣高等法院刑事庭"}

      it { expect{ subject }.to change { judge.verdicts.count } }
    end

    context "create lawyer_verdicts" do
      let!(:lawyer) { FactoryGirl.create :lawyer, name: "陳圈圈" }

      it { expect{ subject }.to change { lawyer.verdicts.count } }
    end

    context "create defendant_verdict" do
      let!(:defendant) { FactoryGirl.create :defendant, name: "張坤樹" }

      it { expect{ subject }.to change { defendant.verdicts.count } }
    end
  end
end
