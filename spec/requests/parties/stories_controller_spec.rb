require "rails_helper"

RSpec.describe Parties::StoriesController, type: :request do
  let!(:party) { create :party, :already_confirmed }
  before { signin_party(party) }

  describe "#index" do
    subject! { get "/party/stories" }
    it { expect(response).to be_success }
  end

  describe "#show" do
    let!(:story) { create :story }

    context "story not found" do
      subject! { get "/party/stories/123213" }
      it { expect(response).to be_redirect }
    end

    context "no score record" do
      subject! { get "/party/stories/#{story.id}" }
      it { expect(response).to be_redirect }
    end

    context "success" do
      let!(:schedule_score) { create :schedule_score, schedule_rater: party, story: story }
      subject! { get "/party/stories/#{story.id}" }
      it { expect(response).to be_success }
    end
  end
end
