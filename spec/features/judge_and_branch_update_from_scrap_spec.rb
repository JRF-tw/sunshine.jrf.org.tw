require 'rails_helper'

describe "從爬蟲資料中更新股別分表", type: :context do
  let!(:court) { FactoryGirl.create :court, code: "TPH", scrap_name: "臺灣高等法院" }

  context "法官的新增" do
    let(:data_string) { "臺灣高等法院民事庭,丁,匡偉　法官,黃千鶴,2415" }
    subject { Scrap::ImportJudgeContext.new(data_string).perform }

    context "同法院下有找到相同姓名的法官" do
      let!(:judge) { FactoryGirl.create :judge, name: "匡偉", court: court }
      it { expect { subject }.not_to change { Judge.count } }
    end
    context "不同法院下有有相同姓名的法官、但同法院下則沒有" do
      let!(:judge) { FactoryGirl.create :judge, name: "匡偉"}
      it { expect { subject }.to change { Judge.count } }
    end
  end

  context "同法院下，法官A有股別甲(missed 為 true)、乙，法官B有股別丙" do
    let!(:judge_A) { FactoryGirl.create :judge, name: "A", court: court }
    let!(:judge_B) { FactoryGirl.create :judge, name: "B", court: court }
    let!(:branch1) { FactoryGirl.create :branch, court: court, name: "甲", judge: judge_A, chamber_name: "臺灣高等法院民事庭", missed: true }
    let!(:branch2) { FactoryGirl.create :branch, court: court, name: "乙", judge: judge_A, chamber_name: "臺灣高等法院民事庭" }
    let!(:branch3) { FactoryGirl.create :branch, court: court, name: "丙", judge: judge_B, chamber_name: "臺灣高等法院民事庭" }
    subject { Scrap::ImportJudgeContext.new(data_string).perform }

    context "從爬蟲資料中新增了法官C" do
      let(:data_string) { "臺灣高等法院民事庭,丁,C　法官,黃千鶴,2415" }

      it { expect(subject.court).to eq(judge_A.court) }

      context "從爬蟲資料中找到了股別丙" do
        let(:data_string) { "臺灣高等法院民事庭,丙,C　法官,黃千鶴,2415" }

        it { expect { subject }.not_to change { Branch.count } }

        before { subject }
        it { expect(branch3.reload.judge).to eq(subject) }
        it { expect(judge_B.branches.count).to eq(0) }
      end

      context "從爬蟲資料中找不到資料庫內的股別" do
        let(:data_string) { "臺灣高等法院民事庭,丁,C　法官,黃千鶴,2415" }
        let(:branch) { Branch.last }
        before { subject }

        it { expect(branch.name).to eq("丁") }
        it { expect(subject.name).to eq("C") }
        it { expect(branch.missed).to be_falsey }
      end

      context "爬蟲資料中僅不存在股別 阿英滷肉飯" do
        let!(:fake_branch) { FactoryGirl.create :branch, court: court, name: "阿英滷肉飯", judge: judge_A, chamber_name: "臺灣高等法院民事庭" }
        subject! { Scrap::GetJudgesContext.new.perform }

        it { expect(branch1.reload.missed).to be_falsey }
        it { expect(fake_branch.reload.missed).to be_truthy }
        it { expect(branch3.reload.missed).to be_falsey }
      end
    end

    context "從爬蟲資料中找到了法官A" do
      context "從爬蟲資料中找到了股別丙" do
        let(:data_string) { "臺灣高等法院民事庭,丙,A　法官,黃千鶴,2415" }
        it { expect{ subject }.not_to change { Branch.count} }

        before { subject }
        it { expect(branch3.reload.judge).to eq(judge_A) }
        it { expect(judge_B.branches.count).to eq(0) }
      end

      context "從爬蟲資料中找不到資料庫內的股別" do
        let(:data_string) { "臺灣高等法院民事庭,丁,A　法官,黃千鶴,2415" }
        let(:branch) { Branch.last }
        before { subject }

        it { expect(branch.name).to eq("丁") }
        it { expect(subject.name).to eq("A") }
        it { expect(branch.missed).to be_falsey }
      end
    end
  end
end
