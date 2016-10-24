require 'rails_helper'

RSpec.describe Scrap::AnalysisVerdictContext, type: :model do
  let!(:story) { create :story }
  let!(:verdict_word) { '測試裁判字別' }

  describe '#judges_names' do
    context 'exist' do
      let!(:verdict_content) { " 法  官  陪審法官\n" }
      subject { described_class.new(story, verdict_content, verdict_word) }

      it { expect(subject.judges_names.present?).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { "法  X  xxx\n" }
      subject { described_class.new(story, verdict_content, verdict_word) }
      it { expect { subject.judges_names }.to change { CrawlerLog.count } }
    end
  end

  describe '#main_judge_name' do
    context 'exist' do
      let!(:verdict_content) { "刑事第四庭    審判長法  官 xxx\n" }
      subject { described_class.new(story, verdict_content, verdict_word) }

      it { expect(subject.main_judge_name.present?).to be_truthy }
      it { expect { subject.main_judge_name }.not_to change { CrawlerLog.count } }
    end

    context 'unexist' do
      let!(:verdict_content) { "恐龍審判長  xxx\n" }
      subject { described_class.new(story, verdict_content, verdict_word) }
      it { expect { subject.main_judge_name }.to change { CrawlerLog.count } }
    end
  end

  describe '#prosecutor_names' do
    context 'exist' do
      let!(:verdict_content) { '檢察官xxxx到庭執行職務' }
      subject { described_class.new(story, verdict_content, verdict_word) }

      it { expect(subject.prosecutor_names.present?).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '檢察官xxxx到處跑執行職務' }
      subject { described_class.new(story, verdict_content, verdict_word) }
      it { expect { subject.prosecutor_names }.to change { CrawlerLog.count } }
    end
  end

  describe '#lawyer_names' do
    context 'exist' do
      let!(:verdict_content) { '選任辯護人　xxx律師' }
      subject { described_class.new(story, verdict_content, verdict_word) }

      it { expect(subject.lawyer_names.present?).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '選任辯護人' }
      subject { described_class.new(story, verdict_content, verdict_word) }
      it { expect { subject.lawyer_names }.to change { CrawlerLog.count } }
    end
  end

  describe '#party_names' do
    context 'exist' do
      let!(:verdict_content) { '被　　　告　xxx' }
      subject { described_class.new(story, verdict_content, verdict_word) }

      it { expect(subject.party_names.present?).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '被衝康 xxx' }
      subject { described_class.new(story, verdict_content, verdict_word) }
      it { expect { subject.party_names }.to change { CrawlerLog.count } }
    end
  end
end
