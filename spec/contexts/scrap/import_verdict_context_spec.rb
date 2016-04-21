require 'rails_helper'

RSpec.describe Scrap::ImportVerdictContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }
  let!(:import_data) { Mechanize.new.get(Scrap::GetVerdictsContext::VERDICT_URI) }

  describe "#perform" do
    context "create verdict" do
      subject{ described_class.new(import_data, court).perform }
      it { expect{ subject }.to change{ Verdict.last } }
    end

    context "find_or_create_story" do
      context "create" do
        subject{ described_class.new(import_data, court).perform }
        it { expect{ subject }.to change{ Story.count } }
      end

      context "find" do
        subject!{ described_class.new(import_data, court).perform }
        it { expect{ subject }.not_to change{ Story.count } }
      end
    end

    context "upload file to s3" do
      subject{ described_class.new(import_data, court).perform }
      it { expect(subject.file).to be_present }
    end
  end
end
