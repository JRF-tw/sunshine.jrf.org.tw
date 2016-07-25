require "rails_helper"

describe "律師後台 刪除律師", type: :request do
  before { signin_user }
  let!(:lawyer) { FactoryGirl.create :lawyer }

  context "已經設定密碼的律師無法刪除" do
    let!(:lawyer_with_password) { create :lawyer, :with_password }
    subject { delete "/admin/lawyers/#{lawyer_with_password.id}", {}, "HTTP_REFERER" => "/admin/lawyers" }

    it "刪除失敗" do
      expect { subject }.not_to change { Lawyer.count }
    end

  end

  context "尚未設定密碼的律師可以刪除" do
    subject { delete "/admin/lawyers/#{lawyer.id}", {}, "HTTP_REFERER" => "/admin/lawyers" }

    it "刪除成功" do
      expect { subject }.to change { Lawyer.count }.by(-1)
    end
  end

  context "刪除後回到原本的列表頁，假如原本是搜尋結果的某一頁，則必須回到該頁" do
    subject! { delete "/admin/lawyers/#{lawyer.id}", {}, "HTTP_REFERER" => "/admin/lawyers?page=2" }

    it "刪除成功" do
      expect(response).to redirect_to("/admin/lawyers?page=2")
    end
  end
end
