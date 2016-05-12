require 'rails_helper'

describe "從最高法院的判決書中爬取審判長法官，並且檢查建立之", type: :context do

  context "來自最高法院的判決書" do
    context "最高法院的法官列表中，姓名已存在" do
      context "其他法院的法官列表中，姓名已存在" do
        it "不建立新法官"
      end
      context "其他法院的法官列表中，姓名不存在" do
        it "不建立新法官"
      end
    end
    context "最高法院的法官列表中，姓名不存在" do
      context "其他法院的法官列表中，姓名已存在" do
        it "建立新法官"
        it "新法官隸屬最高法院"
      end
      context "其他法院的法官列表中，姓名不存在" do
        it "建立新法官"
        it "新法官隸屬最高法院"
      end
    end
  end

  context "來自其他法院的判決書" do
    context "最高法院的法官列表中，姓名已存在" do
      context "其他法院的法官列表中，姓名已存在" do
        it "不建立新法官"
      end
      context "其他法院的法官列表中，姓名不存在" do
        it "不建立新法官"
      end
    end
    context "最高法院的法官列表中，姓名不存在" do
      context "其他法院的法官列表中，姓名已存在" do
        it "不建立新法官"
      end
      context "其他法院的法官列表中，姓名不存在" do
        it "不建立新法官"
      end
    end
  end
end
