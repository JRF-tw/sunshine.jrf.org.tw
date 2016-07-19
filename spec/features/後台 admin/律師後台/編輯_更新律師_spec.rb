require "rails_helper"

describe "律師後台 編輯/更新律師", type: :request do
  before { signin_user }
  let!(:lawyer) { FactoryGirl.create :lawyer }

  context "重複的email無法更新" do
    subject { put "/admin/lawyers/#{lawyer.id}", admin_lawyer: { name: "跳跳虎", email: lawyer.email } }

    it "更新失敗" do
      expect { subject }.not_to change { lawyer.reload.email }
    end
  end

  context "email空白無法更新" do
    subject { put "/admin/lawyers/#{lawyer.id}", admin_lawyer: { name: "跳跳虎", email: "" } }

    it "更新失敗" do
      expect { subject }.not_to change { lawyer.reload.email }
    end
  end

  context "姓名空白無法更新" do
    subject { put "/admin/lawyers/#{lawyer.id}", admin_lawyer: { name: "", email: "ggcc11@gmail.com" } }

    it "更新失敗" do
      expect { subject }.not_to change { lawyer.reload.name }
    end
  end

  context "填入email 姓名 更新成功" do
    subject { put "/admin/lawyers/#{lawyer.id}", admin_lawyer: { name: "我愛棒棒糖", email: "ggcc11@gmail.com" } }

    it "更新成功" do
      expect { subject }.to change { lawyer.reload.name }
    end
  end
end
