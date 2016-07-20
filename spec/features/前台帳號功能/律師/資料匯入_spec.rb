require "rails_helper"

describe "律師資料匯入", type: :request do
  context "已存在的律師資料（email）" do
    it "跳過不匯入" do
    end
  end

  context "未存在的律師資料，且資料無姓名或 email" do
    it "跳過不匯入" do
    end
  end

  context "未存在的律師資料，且至少有 email 和姓名" do
    it "成功匯入" do
    end

    it "不會發送註冊信" do
    end

    it "不會發送密碼設定信" do
    end
  end
end
