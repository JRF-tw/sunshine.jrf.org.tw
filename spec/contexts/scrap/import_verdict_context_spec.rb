require 'rails_helper'

RSpec.describe Scrap::ImportVerdictContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }
  let!(:judge) { FactoryGirl.create :judge, name: "施俊堯" }
  let!(:import_data) { Mechanize.new.get(Scrap::GetVerdictsContext::VERDICT_URI) }

  describe "#perform" do
    subject{ described_class.new(import_data, court).perform }
    context "create verdict" do
      it { expect{ subject }.to change{ Verdict.last } }
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

    context "sync analysis data to story" do
      before { subject }
      it { expect(subject.judges_names).to eq(subject.story.judges_names) }
      it { expect(subject.prosecutor_names).to eq(subject.story.prosecutor_names) }
      it { expect(subject.defendant_names).to eq(subject.story.defendant_names) }
      it { expect(subject.lawyer_names).to eq(subject.story.lawyer_names) }
      it { expect(subject.story.main_judge).to be_present }
    end
  end
end
