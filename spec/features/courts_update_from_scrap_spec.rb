require 'rails_helper'

describe "爬蟲更新法院資料的機制", type: :request do
  context "爬蟲抓到資料(包含法院代號和法院名稱)" do
    context "爬蟲的法院代號、資料庫沒有" do
      let(:data_hash) { { scrap_name: "爬蟲名稱", code: "法院代碼" } }
      subject { Scrap::ImportCourtContext.new(data_hash).perform }

      it "新增至資料庫" do
        expect { subject }.to change { Court.count }
      end

      it "新資料的爬蟲名稱和抓到的名稱一樣" do
        expect(subject.scrap_name).to eq(data_hash[:scrap_name])
      end

      it "新資料的簡稱和抓到的名稱一樣" do
        expect(subject.name).to eq(data_hash[:scrap_name])
      end

      it "新資料的全名和抓到的名稱一樣" do
        expect(subject.full_name).to eq(data_hash[:scrap_name])
      end
    end

    context "爬蟲的法院代號、資料庫有" do
      let(:data_hash) { { scrap_name: "爬蟲名稱", code: "法院代碼" } }
      let!(:court) { FactoryGirl.create(:court, code: "法院代碼") }
      subject { Scrap::ImportCourtContext.new(data_hash).perform }

      it "更新該筆資料的爬蟲名稱" do
        expect(subject.scrap_name).to eq(data_hash[:scrap_name])
      end

      context "爬蟲名稱和全名不相同時" do
        let!(:court) { FactoryGirl.create(:court, code: "法院代碼", full_name: "舊全名") }

        it "不會更新該筆資料的全名" do
          expect(subject.full_name).not_to eq(data_hash[:scrap_name])
        end

        it "做 slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "爬蟲名稱和簡稱不相同、但全名是相同" do
        let!(:court) { FactoryGirl.create(:court, code: "法院代碼", name: "舊簡稱", full_name: "爬蟲名稱") }

        it "不會更新該筆資料的簡稱" do
          expect(subject.name).not_to eq(data_hash[:scrap_name])
        end

        it "不做 slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end

    context "資料庫的法院代號、爬蟲沒有" do
      let!(:court) { FactoryGirl.create(:court, code: "法院代碼", name: "舊簡稱", full_name: "舊全名", scrap_name: "爬蟲名稱") }
      let!(:court1) { FactoryGirl.create(:court, code: "法院代碼1", name: "舊簡稱", full_name: "舊全名", scrap_name: "爬蟲名稱") }
      subject { Scrap::GetCourtsContext.new.perform }

      it "該筆資料不會有任何名稱上的變動(本來就不會有, 因為根本沒資料匯入)"

      it "該筆資料會進行 slack 通知" do
        expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(2)
      end
    end
  end

  context "後台" do
    let!(:court) { FactoryGirl.create :court, court_type: "法院", full_name: "台北第一法院", name: "台北第一" }
    subject { put "/admin/courts/#{court.id}", admin_court: { scrap_name: "haha" } }

    it "無法更新爬蟲名稱" do
      expect { subject }.not_to change { court.reload.scrap_name }
    end
  end
end
