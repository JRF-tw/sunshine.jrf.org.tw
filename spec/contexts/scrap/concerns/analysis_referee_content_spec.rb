require 'rails_helper'

RSpec.describe Concerns::Scrap::AnalysisRefereeContentConcern, type: :model do
  let!(:verdict) { create(:verdict) }
  let!(:crawler_history) { create(:crawler_history) }
  let(:including_class) {
    Class.new do
      include Concerns::Scrap::AnalysisRefereeContentConcern
    end.new
  }

  describe '#parse_judges_names' do
    context 'exist' do
      let(:verdict_content) { " 法  官  陪審法官\n" }
      subject { including_class.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { "法  X  xxx\n" }
      subject { including_class.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end

    context 'check 法官 in line last' do
      let!(:verdict_content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_example_1.html") }
      subject { including_class.parse_judges_names(verdict, verdict_content, crawler_history) }
      it { expect(subject.count).to eq(5) }
    end
  end

  describe '#parse_main_judge_name' do
    context 'exist' do
      let!(:verdict_content) { "刑事第四庭    審判長法  官 xxx\n" }
      subject { including_class.parse_main_judge_name(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { "恐龍審判長  xxx\n" }
      subject { including_class.parse_main_judge_name(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_prosecutor_names' do
    context 'exist' do
      let!(:verdict_content) { '檢察官xxxx到庭執行職務' }
      subject { including_class.parse_prosecutor_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '檢察官xxxx到處跑執行職務' }
      subject { including_class.parse_prosecutor_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_lawyer_names' do
    context 'exist' do
      let!(:verdict_content) { '選任辯護人　xxx律師' }
      subject { including_class.parse_lawyer_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to be_truthy }
    end

    context 'unexist' do
      let!(:verdict_content) { '選任辯護人' }
      subject { including_class.parse_lawyer_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#parse_party_names' do
    context 'include lawyer' do
      let!(:verdict_content) { "\r\n103年度無敵字第541號 \r\n被　　　告　張火旺\r\n原   告　張文雅律師\n上列" }
      subject { including_class.parse_party_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to include('張火旺') }
    end

    context 'not include lawyer' do
      let!(:verdict_content) { "\r\n103年度無敵字第541號 \r\n被　　　告　張火旺\n上列" }
      subject { including_class.parse_party_names(verdict, verdict_content, crawler_history) }
      it { expect(subject).to include('張火旺') }
    end

    context 'unexist' do
      let!(:verdict_content) { "\r\n103年度無敵字第541號 \r\n被　　　打　火旺張\n上列" }
      subject { including_class.parse_party_names(verdict, verdict_content, crawler_history) }
      it { expect { subject }.to change { CrawlerLog.count } }
    end
  end

  describe '#prase_related_story' do
    context 'more than one story' do
      let!(:verdict_content) { "105年度上易字第541號\r\n 105年度上易字第545號\r\n 105年度上火字第547號\r\n 上列" }
      subject { including_class.prase_related_story(verdict_content) }
      it { expect(subject).to eq(['105年度上易字第545號', '105年度上火字第547號']) }
    end

    context 'one story' do
      let!(:verdict_content) { "105年度上易字第541號\r\n 上列" }
      subject { including_class.prase_related_story(verdict_content) }
      it { expect(subject).to eq([]) }
    end
  end

  describe '#parse_roles_hash' do
    let!(:main_titles) { ['代表人', '上 訴 人', '聲請人', '受 刑 人', '抗 告人', '公 訴 人', '選任辯護人', '被  告', '共同', '再抗告人', '兼代表人', '上一被告'] }
    let!(:sub_titles) { ["\r\n即再審聲請人", "\r\n即受刑人", "\r\n即受判決人", "\r\n即被告", "\r\n選任辯護人"] }

    def test_template(main_title:, sub_title: '', plus_people: 0)
      people_names = ["\s邱政則", "\s王陽明有限公司", "\s火雞律師", "\s陳威志（原名：陳宥菖）", "\s邵瑋", "\s李 辰"]
      plus_people_name = ["\r\n      梁維祥律師", "\r\n      林啟智", "\r\n      黃仁到（原名：黃宥豬）"]
      "\r\n103年度無敵字第541號" + "\r\n" + main_title + sub_title + people_names.sample + plus_people_name.sample(plus_people).join + '上列'
    end

    context 'only main title' do
      context 'single people' do
        let!(:verdict_content) { test_template(main_title: main_titles.sample) }
        subject { including_class.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject.present?).to be_truthy }
      end

      context 'mutiple people' do
        let(:main_title) { main_titles.sample }
        let(:title) { main_title.delete(' ') }
        let!(:verdict_content) { test_template(main_title: main_title, plus_people: 1) }
        subject { including_class.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject[title].count).to eq(2) }
      end
    end

    context 'with sub title' do
      context 'single people' do
        let!(:verdict_content) { test_template(main_title: main_titles.sample, sub_title: sub_titles.sample) }
        subject { including_class.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject.present?).to be_truthy }
      end

      context 'mutiple people' do
        let(:main_title) { main_titles.sample }
        let(:sub_title) { sub_titles.sample }
        let(:title) { (main_title + sub_title).squish.delete(' ') }
        let!(:verdict_content) {  test_template(main_title: main_title, sub_title: sub_title, plus_people: 1) }
        subject { including_class.parse_roles_hash(verdict, verdict_content, crawler_history) }
        it { expect(subject[title].count).to eq(2) }
      end
    end

    context 'check role number' do
      let!(:verdict_content) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_example_1.html") }
      subject { including_class.parse_roles_hash(verdict, verdict_content, crawler_history) }
      it { expect { subject }.not_to change { CrawlerLog.count } }
    end
  end
end
