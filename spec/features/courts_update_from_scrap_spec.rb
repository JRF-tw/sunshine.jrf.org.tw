require 'rails_helper'

describe "爬蟲更新法院資料的機制", type: :request do
  context "爬蟲抓到資料(包含法院代號和法院名稱)" do
    context "爬蟲的法院代號、資料庫沒有" do
      let(:data_hash) { { scrap_name: "爬蟲名稱", code: "法院代碼" } }
      subject{ Scrap::ImportCourtContext.new(data_hash).perform }

      it { expect{ subject }.to change { Court.count } }
      it { expect(subject.scrap_name).to eq(data_hash[:scrap_name]) }
      it { expect(subject.name).to eq(data_hash[:scrap_name]) }
      it { expect(subject.full_name).to eq(data_hash[:scrap_name]) }
    end

    context "爬蟲的法院代號、資料庫有" do
      let(:data_hash) { { scrap_name: "爬蟲名稱", code: "法院代碼" } }
      let!(:court) { FactoryGirl.create(:court, code: "法院代碼") }
      subject{ Scrap::ImportCourtContext.new(data_hash).perform }

      it { expect(subject.scrap_name).to eq(data_hash[:scrap_name]) }

      context "爬蟲名稱和全名不相同時" do
        let!(:court) { FactoryGirl.create(:court, code: "法院代碼", full_name: "舊全名") }

        it { expect(subject.full_name).not_to eq(data_hash[:scrap_name]) }
        it { expect{ subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "爬蟲名稱和簡稱不相同、但全名是相同" do
        let!(:court) { FactoryGirl.create(:court, code: "法院代碼", name: "舊簡稱", full_name: "爬蟲名稱") }

        it { expect(subject.name).not_to eq(data_hash[:scrap_name]) }
        it { expect{ subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context "資料庫的法院代號、爬蟲沒有" do
      let!(:court) { FactoryGirl.create(:court, code: "法院代碼", name: "舊簡稱", full_name: "舊全名", scrap_name: "爬蟲名稱") }
      let!(:court1) { FactoryGirl.create(:court, code: "法院代碼", name: "舊簡稱", full_name: "舊全名", scrap_name: "爬蟲名稱1") }
      subject { Scrap::GetCourtsContext.new.perform }

      it "該筆資料不會有任何名稱上的變動(本來就不會有, 因為根本沒資料匯入)"
      it { expect{ subject }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(2) }
    end
  end

  context "後台" do
    let!(:court) { FactoryGirl.create :court, court_type: "法院", full_name: "台北第一法院", name: "台北第一" }
    subject { put "/admin/courts/#{court.id}", admin_court: { scrap_name: "haha" } }

    it { expect { subject }.not_to change{ court.reload.scrap_name } }
  end
end
