require 'rails_helper'

RSpec.describe Scrap::AnalysisVerdictContext, :type => :model do
  let!(:import_data) { Mechanize.new.get(Scrap::GetVerdictsContext::VERDICT_URI) }
  let!(:content){ Nokogiri::HTML(import_data.body).css("pre").text }
  subject{ described_class.new(content) }

  describe "#is_judgment?" do
    it { expect(subject.is_judgment?).to be_truthy }
  end

  describe "#judges_names" do
    it { expect(subject.judges_names).to be_a_kind_of(Array) }
    it { expect(subject.judges_names.count > 0).to be_truthy }
  end

  describe "#prosecutor_names" do
    it { expect(subject.prosecutor_names).to be_a_kind_of(Array) }
    it { expect(subject.prosecutor_names.count == 0).to be_truthy }
  end

  describe "#lawyer_names" do
    it { expect(subject.lawyer_names).to be_a_kind_of(Array) }
    it { expect(subject.prosecutor_names.count == 0).to be_truthy }
  end

  describe "#defendant_names" do
    it { expect(subject.defendant_names).to be_a_kind_of(Array) }
    it { expect(subject.defendant_names.count > 0).to be_truthy }
  end
end
