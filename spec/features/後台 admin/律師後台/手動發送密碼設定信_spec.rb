require "rails_helper"

describe "律師後台 手動發送密碼設定信", type: :request do
  before { signin_user }
  let!(:lawyer) { FactoryGirl.create :lawyer }

  context "可以重複發送" do
    before { post "/admin/lawyers/#{lawyer.id}/send_reset_password_mail" }
    subject { post "/admin/lawyers/#{lawyer.id}/send_reset_password_mail" }

    it "發送成功" do
      expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end
  end

  context "從後台發送密碼設定信後 => 前台輸入新的密碼 => 自動成功登入" do
    let!(:token) { lawyer.send_reset_password_instructions }
    subject! { put "/lawyer/password", lawyer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

    it "登入成功" do
      expect(response).to redirect_to("/lawyer")
      expect(flash[:notice]).to eq("您的密碼已被修改。")
    end
  end
end
