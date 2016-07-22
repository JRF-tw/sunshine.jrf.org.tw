require "rails_helper"

describe "律師後台 建立律師", type: :request do
  before { signin_user }
  let!(:lawyer) { FactoryGirl.create :lawyer }

  context "建立後不發送密碼設定信" do
    subject { post "/admin/lawyers", admin_lawyer: { name: "張冠李戴", email: lawyer.email } }

    it "不發送密碼設定信" do
      expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end
  end

  context "重複的email無法建立" do
    subject { post "/admin/lawyers", admin_lawyer: { name: "張冠李戴", email: lawyer.email } }

    it "建立失敗" do
      expect { subject }.not_to change { Lawyer.count }
    end
  end

  context "重複的姓名可以建立" do
    subject { post "/admin/lawyers", admin_lawyer: { name: lawyer.name, email: "aron@example.com" } }

    it "建立成功 導向至該律師個人資料頁" do
      expect { subject }.to change { Lawyer.count }.by(1)
      expect(subject).to redirect_to("/admin/lawyers/#{Lawyer.last.id}")
    end
  end
end
