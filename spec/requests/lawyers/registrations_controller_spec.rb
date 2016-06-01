require 'rails_helper'

RSpec.describe Lawyers::RegistrationsController, type: :request do

  describe "create" do
    context "success" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyers",  lawyer: { name: lawyer.name, email: lawyer.email} }
      it { expect(response).to redirect_to("/lawyers/sign_in") }
      it { expect(flash[:notice]).to eq("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")}
    end

    context "lawyer not found" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyers",  lawyer: { name: "先生", email: "1234@example.com"} }

      it { expect(subject).to redirect_to("/lawyers/sign_up") }
      it { expect(flash[:notice]).to be_present}
    end

    context "empty params" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyers",  lawyer: { name: "", email: ""} }

      it { expect(subject).to redirect_to("/lawyers/sign_up") }
      it { expect(flash[:notice]).to be_present}
    end

    context "lawyer already active" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
      before { post "/lawyers",  lawyer: { name: lawyer.name, email: lawyer.email} }

      it { expect(response).to redirect_to("/lawyers/sign_in") }
      it { expect(flash[:notice]).to eq("該資料已經註冊 請直接登入")}
    end
  end

end
