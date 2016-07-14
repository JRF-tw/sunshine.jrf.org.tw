require "rails_helper"

RSpec.describe Observer::PasswordsController, type: :request do
  let!(:court_observer) { FactoryGirl.create :court_observer }
  let(:token) { court_observer.send_reset_password_instructions }

  describe "#update" do
    context "success with login" do
      before { signin_court_observer(court_observer) }
      subject! { put "/observer/password", court_observer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/observer") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
    end

    context "success without login" do
      subject! { put "/observer/password", court_observer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/observer") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
    end
  end

  describe "#edit" do
    context "success with sign in" do
      before { signin_court_observer(court_observer) }
      subject { get "/observer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "success without sign in" do
      subject { get "/observer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "fail with sign in other court_observer" do
      before { signin_court_observer }
      subject! { get "/observer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 302 }
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_court_observer }
    subject! { post "/observer/password/send_reset_password_mail" }

    it { expect(response).to redirect_to("/observer/profile") }
  end

end
