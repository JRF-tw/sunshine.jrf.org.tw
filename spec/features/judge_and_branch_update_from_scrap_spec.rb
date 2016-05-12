require 'rails_helper'

describe "從爬蟲資料中更新股別分表", type: :context do

  context "法官的新增" do
    context "同法院下有找到相同姓名的法官" do
      it "不會新增法官"
    end
    context "不同法院下有有相同姓名的法官、但同法院下則沒有" do
      it "會新增法官"
    end
  end

  context "同法院下，法官A有股別甲(missed 為 true)、乙，法官B有股別丙" do
    context "從爬蟲資料中新增了法官C" do

      it "法官C和法官A同法院"

      context "從爬蟲資料中找到了股別丙" do
        it "不會新增股別"
        it "股別丙隸屬法官C"
        it "法官B沒有股別"
      end

      context "從爬蟲資料中找不到資料庫內的股別" do
        it "新增了股別丁"
        it "股別丁隸屬法官C"
        it "股別丁的 missed 為 false"
      end

      context "爬蟲資料中僅不存在股別乙" do
        it "股別甲的 missed 為 false"
        it "股別乙的 missed 為 true"
        it "股別丙的 missed 為 false(不變)"
      end
    end

    context "從爬蟲資料中找到了法官A" do
      context "從爬蟲資料中找到了股別丙" do
        it "不會新增股別"
        it "股別丙隸屬法官A"
        it "法官B沒有股別"
      end

      context "從爬蟲資料中找不到資料庫內的股別" do
        it "新增了股別丁"
        it "股別丁隸屬法官A"
        it "股別丁的 missed 為 false"
      end
    end
  end
end
