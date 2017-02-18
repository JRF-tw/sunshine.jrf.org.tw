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

  describe '#parse_roles_hash' do
    let(:main_titles) { ['代表人', '上 訴 人', '聲請人', '受 刑 人', '抗 告人', '公 訴 人', '選任辯護人', '被  告', '共同', '再抗告人', '兼代表人', '上一被告'] }
    let(:sub_titles) { ['即再審聲請人', '即受刑人', '即受判決人', '即被告', '選任辯護人'] }
    let(:people_name) { ['邱政則', '王陽明有限公司', '火雞律師', '陳威志（原名：陳宥菖）'] }
    let(:plus_people_name) { ["\r\n      梁維祥律師", "\r\n      林啟智", "\r\n      黃仁到（原名：黃宥豬）"] }
    context 'only main title' do
      context 'single people' do
        let!(:verdict_content) { '號' + main_titles.sample + "\s" + people_name.sample + '上列' }
        subject { including_class.new.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject.present?).to be_truthy }
      end

      context 'mutiple people' do
        let(:main_title) { main_titles.sample }
        let(:title) { main_title.delete(' ') }
        let!(:verdict_content) { '號' + main_title + "\s" + people_name.sample + plus_people_name[0] + plus_people_name[1] + '上列' }
        subject { including_class.new.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject[title].count).to eq(3) }
      end
    end

    context 'with sub title' do
      context 'single people' do
        let!(:verdict_content) { '號' + main_titles.sample + "\r\n" + sub_titles.sample + "\s" + people_name.sample + '上列' }
        subject { including_class.new.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject.present?).to be_truthy }
      end

      context 'mutiple people' do
        let(:main_title) { main_titles.sample }
        let(:sub_title) { sub_titles.sample }
        let(:title) { (main_title + sub_title).delete(' ') }
        let!(:verdict_content) { '號' + main_title + "\r\n" + sub_title + "\s" + people_name.sample + plus_people_name.sample + '上列' }
        subject { including_class.new.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject[title].count).to eq(2) }
      end
    end
  end
end
