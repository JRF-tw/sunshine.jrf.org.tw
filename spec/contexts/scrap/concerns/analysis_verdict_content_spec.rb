require 'rails_helper'

RSpec.describe Scrap::Concerns::AnalysisVerdictContent, type: :model do
  let!(:verdict) { create(:verdict) }
  let!(:crawler_history) { create(:crawler_history) }
  let(:including_class) {
    Class.new do
      include Scrap::Concerns::AnalysisVerdictContent
    end
  }

  describe '#parse_judges_names' do
    context 'exist' do
      let(:verdict_content) { " 法  官  陪審法官\n" }
      subject { including_class.new.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { "法  X  xxx\n" }
      subject { including_class.new.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end

    context 'check 法官 in line last' do
      let!(:verdict_content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_example_1.html") }
      subject { including_class.new.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect(subject.count).to eq(5) }
    end
  end

  describe '#parse_main_judge_name' do
    context 'exist' do
      let!(:verdict_content) { "刑事第四庭    審判長法  官 xxx\n" }
      subject { including_class.new.parse_main_judge_name(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { "恐龍審判長  xxx\n" }
      subject { including_class.new.parse_main_judge_name(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_prosecutor_names' do
    context 'exist' do
      let!(:verdict_content) { '檢察官xxxx到庭執行職務' }
      subject { including_class.new.parse_prosecutor_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '檢察官xxxx到處跑執行職務' }
      subject { including_class.new.parse_prosecutor_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_lawyer_names' do
    context 'exist' do
      let!(:verdict_content) { '選任辯護人　xxx律師' }
      subject { including_class.new.parse_lawyer_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '選任辯護人' }
      subject { including_class.new.parse_lawyer_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_party_names' do
    context 'exist' do
      let!(:verdict_content) { '被　　　告　xxx' }
      subject { including_class.new.parse_party_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '被衝康 xxx' }
      subject { including_class.new.parse_party_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end
end
