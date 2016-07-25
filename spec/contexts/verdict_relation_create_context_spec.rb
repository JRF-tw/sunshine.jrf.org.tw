require "rails_helper"

describe VerdictRelationCreateContext do
  let!(:court) { create :court }
  let!(:story) { create :story, court: court, story_type: "民事" }
  let!(:verdict) { create :verdict, party_names: ["party"], lawyer_names: ["lawyer"], judges_names: ["judge"], story: story }
  subject { described_class.new(verdict) }

  context "create party" do
    let!(:party) { create :party, name: "party" }

    it { expect { subject.perform(verdict.party_names.first) }.to change { party.verdict_relations.count } }
  end

  context "create lawyer" do
    let!(:lawyer) { create :lawyer, name: "lawyer" }

    it { expect { subject.perform(verdict.lawyer_names.first) }.to change { lawyer.verdict_relations.count } }
  end

  context "create judge" do
    let!(:judge) { create :judge, name: "judge" }
    let!(:branch) { create :branch, judge: judge, court: court, chamber_name: "xxx民事庭" }

    it { expect { subject.perform(verdict.judges_names.first) }.to change { judge.verdict_relations.count } }

    context "find same name but diff branch judge" do
      let!(:judge1) { create :judge, name: "judge" }
      before { subject.perform(verdict.judges_names.first) }

      it { expect(VerdictRelation.last.person).to eq(judge) }
      it { expect(VerdictRelation.last.person).not_to eq(judge1) }
    end
  end

  context "name not in verdict" do
    it { expect(subject.perform("xxx")).to be_falsey }
  end

  context "name has many people" do
    let!(:judge) { create_list :lawyer, 2, name: "lawyer" }
    it { expect(subject.perform(verdict.lawyer_names.first)).to be_falsey }
  end
end
