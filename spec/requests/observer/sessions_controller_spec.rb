require "rails_helper"

RSpec.describe Observer::SessionsController, type: :request do
  let!(:court_observer) { create :court_observer }

  describe "#create" do
    context "success" do
      subject! { post "/observer/sign_in", court_observer: { email: court_observer.email, password: "123123123" } }

      it { expect(court_observer.reload.last_sign_in_at).to be_present }
      it { expect(response).to redirect_to("/observer") }
    end

    context "without validate email" do
      let!(:court_observer_without_validate) { create :court_observer_without_validate }
      subject! { post "/observer/sign_in", court_observer: { email: court_observer_without_validate.email, password: court_observer_without_validate.password } }

      it { expect(court_observer_without_validate.reload.last_sign_in_at).to be_nil }
      it { expect(response).to redirect_to("/observer/sign_in") }
    end

    context "root should not change" do
      subject! { signin_court_observer }

      it { expect(get("/")).to render_template("base/index") }
    end
  end

  describe "#destroy" do
    context "success" do
      before { signin_court_observer }
      subject { delete "/observer/sign_out" }

      it { expect(subject).to redirect_to("/observer/sign_in") }
    end

    context "only sign out lawyer" do
      before { signin_court_observer }
      before { signin_lawyer }
      subject! { delete "/observer/sign_out" }

      it { expect(get("/lawyer/profile")).to eq(200) }
      it { expect(get("/observer/profile")).to eq(302) }
    end
  end

end
