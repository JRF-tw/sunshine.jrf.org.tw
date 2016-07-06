require "rails_helper"

describe "登入", type: :request do
  context "成功登入" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password, :with_confirmed }
    subject { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: lawyer.password } }

    it "導到個人評鑑紀錄頁" do
      expect(subject).to redirect_to("/lawyer/scores")
    end
  end

  context "失敗登入" do
    context "email不存在" do
      before { post "/lawyer/sign_in", lawyer: { email: "aaaa22@gamil.com", password: "password" } }
      it { expect(flash[:alert]).to eq("輸入資訊是無效的。") }
    end

    context "email 密碼皆正確，但該帳號尚未設定密碼" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password }
      before { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: lawyer.password } }
      it { expect(flash[:alert]).to eq("您的帳號需需要經過驗證後，才能繼續。") }
    end

    context "email 格式不符" do
      before { post "/lawyer/sign_in", lawyer: { email: "aaaa2", password: "password" } }
      it { expect(flash[:alert]).to eq("輸入資訊是無效的。") }
    end

    context "email 空白" do
      before { post "/lawyer/sign_in", lawyer: { email: "", password: "password" } }
      it { expect(flash[:alert]).to eq("信箱或密碼是無效的。") }
    end

    context "密碼空白 + email 正確" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password }
      before { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: "" } }
      it { expect(flash[:alert]).to eq("輸入資訊是無效的。") }
    end

    context "密碼不正確 + email 正確" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password }
      before { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: "ppwwppww" } }
      it "失敗後轉跳的頁面仍須保留原本輸入的 email" do
        expect(response.body).to match(lawyer.email)
      end
    end

  end

end
