require "rails_helper"

describe "律師忘記密碼", type: :request do
  context "成功送出" do
    let!(:lawyer) { create :lawyer, :with_confirmed, :with_password, email: "firewizard@gmail.com" }
    let!(:params) { { email: "firewizard@gmail.com" } }
    subject { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }

    it "發送重設密碼信" do
      expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end
  end

  context "失敗送出" do
    let!(:lawyer) { create :lawyer, :with_confirmed, :with_password, email: "firewizard@gmail.com" }

    context "email 空白" do
      let!(:params) { { email: "" } }
      subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }

      it "顯示查無此律師帳號" do
        follow_redirect!
        expect(response.body).to match("無此律師帳號")
      end
    end

    context "email 格式不符" do
      let!(:params) { { email: "firewizar" } }
      subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }

      it "顯示查無此律師帳號" do
        follow_redirect!
        expect(response.body).to match("無此律師帳號")
      end
    end

    context "email 不存在" do
      let!(:params) { { email: "icewizard@gmail.com" } }
      subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }

      it "顯示查無此律師帳號" do
        follow_redirect!
        expect(response.body).to match("無此律師帳號")
      end
    end

    context "該帳號存在，但是尚未完成註冊" do
      let!(:lawyer_unconfirmed) { create :lawyer, :with_password, email: "windwizard@gmail.com" }
      subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/password/new" }
      let!(:params) { { email: "windwizard@gmail.com" } }

      it "顯示該帳號尚未註冊" do
        follow_redirect!
        expect(response.body).to match("該帳號尚未註冊")
      end
    end
  end

  context "重設密碼頁" do
    it "(和註冊的密碼設定同一頁，所以不用再重複測試)" do
    end
  end
end
