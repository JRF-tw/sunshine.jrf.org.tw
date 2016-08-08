require "rails_helper"

RSpec.describe Observers::StoriesController, type: :request do
  let!(:court_observer) { create :court_observer }
  before { signin_court_observer(court_observer) }

  describe "#index" do
    subject! { get "/observer/stories" }
    it { expect(response).to be_success }
  end

  describe "#show" do
    let!(:story) { create :story }

    context "story not found" do
      subject! { get "/observer/stories/123213" }
      it { expect(response).to be_redirect }
    end

    context "no score record" do
      subject! { get "/observer/stories/#{story.id}" }
      it { expect(response).to be_redirect }
    end

    context "success" do
      let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, story: story }
      subject! { get "/observer/stories/#{story.id}" }
      it { expect(response).to be_success }
    end
  end
end
