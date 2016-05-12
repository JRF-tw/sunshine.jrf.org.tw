require 'rails_helper'

describe "爬蟲更新法院資料的機制", type: :request do
  context "爬蟲抓到資料(包含法院代號和法院名稱)" do
    context "爬蟲有、資料庫沒有" do
      it "新增至資料庫"
      it "新資料的爬蟲名稱和抓到的名稱一樣"
      it "新資料的顯示名稱和抓到的名稱一樣"
    end

    context "爬蟲有、資料庫有" do
      it "更新該筆資料的爬蟲名稱"
      context "爬蟲名稱和顯示名稱不相同時" do
        it "不會更新該筆資料的顯示名稱"
        it "做 slack 通知"
      end
    end

    context "爬蟲沒有、資料庫有" do
      it "該筆資料不會有名稱上的變動"
      it "該筆資料會進行 slack 通知"
    end
  end

  context "後台" do
    it "無法更新爬蟲名稱"
  end
end
