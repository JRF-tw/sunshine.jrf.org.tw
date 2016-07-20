require "rails_helper"

RSpec.describe Admin::ObserversController do
  before { signin_user }
  let!(:court_observer) { create :court_observer }

  describe "#index" do
    context "render success" do
      before { get "/admin/observers" }
      it { expect(response).to be_success }
    end

    context "search name" do
      before { get "/admin/observers", q: { name_cont: court_observer.name } }
      it { expect(response.body).to match(court_observer.email) }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/observers/#{court_observer.id}" }
      it { expect(response).to be_success }
    end
  end

  describe "#download_file" do
    let!(:court_observer) { create :court_observer }

    context "success" do
      subject { get "/admin/observers", format: :xlsx }
      it { expect(subject).to be(200) }
    end

    context "after search success" do
      before { get "/admin/observers", q: { name_cont: court_observer.name } }
      subject { get "/admin/observers", format: :xlsx }
      it { expect(subject).to be(200) }
    end
  end
end
