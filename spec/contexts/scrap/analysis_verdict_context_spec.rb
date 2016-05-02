require 'rails_helper'

RSpec.describe Scrap::AnalysisVerdictContext, :type => :model do
  let!(:verdict_word){ "測試裁判字別" }

  describe "#is_judgment?" do
    context "is judgment" do
      let!(:verdict_content){ "判決" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.is_judgment?).to be_truthy }
    end

    context "is judgment" do
      let!(:verdict_content){ "裁決" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.is_judgment?).to be_falsey }
    end
  end

  describe "#judges_names" do
    context "exist" do
      let!(:verdict_content){ "法  官  xxxx\n" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.judges_names.present?).to be_truthy }
      it { expect{ subject.judges_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "unexist" do
      context "notify" do
        let!(:verdict_content){ "判決 法  X  xxx\n" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.judges_names }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "unnotify" do
        let!(:verdict_content){ "法  X  xxx\n" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.judges_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end

  describe "#main_judge_name" do
    context "exist" do
      let!(:verdict_content){ "審判長法 官 xxx\n" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.main_judge_name.present?).to be_truthy }
      it { expect{ subject.main_judge_name }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "unexist" do
      context "notify" do
        let!(:verdict_content){ "判決 恐龍審判長  xxx\n" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.main_judge_name }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "unnotify" do
        let!(:verdict_content){ "恐龍審判長  xxx\n" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.main_judge_name }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end

  describe "#prosecutor_names" do
    context "exist" do
      let!(:verdict_content){ "檢察官xxxx到庭執行職務" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.prosecutor_names.present?).to be_truthy }
      it { expect{ subject.prosecutor_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "unexist" do
      context "notify" do
        let!(:verdict_content){ "判決 檢察官xxxx到處跑執行職務" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.prosecutor_names }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "unnotify" do
        let!(:verdict_content){ "檢察官xxxx到處跑執行職務" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.prosecutor_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end

  describe "#lawyer_names" do
    context "exist" do
      let!(:verdict_content){ "選任辯護人　xxx律師" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.lawyer_names.present?).to be_truthy }
      it { expect{ subject.lawyer_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "unexist" do
      context "notify" do
        let!(:verdict_content){ "判決 選任辯護人" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.lawyer_names }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "unnotify" do
        let!(:verdict_content){ "選任辯護人" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.lawyer_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end

  describe "#defendant_names" do
    context "exist" do
      let!(:verdict_content){ "被　　　告　xxx" }
      subject{ described_class.new(verdict_content, verdict_word) }

      it { expect(subject.defendant_names.present?).to be_truthy }
      it { expect{ subject.defendant_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "unexist" do
      context "notify" do
        let!(:verdict_content){ "判決 被衝康 xxx" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.defendant_names }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "unnotify" do
        let!(:verdict_content){ "被衝康 xxx" }
        subject{ described_class.new(verdict_content, verdict_word) }
        it { expect{ subject.defendant_names }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end
end
