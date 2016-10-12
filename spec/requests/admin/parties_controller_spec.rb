require "rails_helper"

RSpec.describe Admin::PartiesController do
  before { signin_user }
  let!(:party) { create :party }

  describe "#index" do
    context "render success" do
      before { get "/admin/parties" }
      it { expect(response).to be_success }
    end

    context "search name" do
      before { get "/admin/parties", q: { name_cont: party.name } }
      it { expect(response.body).to match(party.phone_number) }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/parties/#{party.id}" }
      it { expect(response).to be_success }
    end
  end

  describe "#set_to_imposter" do
    context "success" do
      before { put "/admin/parties/#{party.id}/set_to_imposter" }
      it { expect(response).to redirect_to("/admin/parties") }
    end
  end

  describe "#stories" do
    context "have stories" do
      let(:story) { create :story }
      let!(:story_relation) { create :story_relation, people: party, story: story }
      subject! { get "/admin/parties/#{party.id}/stories" }
      it { expect(response.body).to match(story.story_type) }
    end

    context "don't have stories" do
      subject! { get "/admin/parties/#{party.id}/stories" }
      it { expect(response).to be_success }
    end
  end
end
