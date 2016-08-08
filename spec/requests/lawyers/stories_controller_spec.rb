require "rails_helper"

RSpec.describe Lawyers::StoriesController, type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  before { signin_lawyer(lawyer) }

  describe "#index" do
    subject! { get "/lawyer/stories" }
    it { expect(response).to be_success }
  end

  describe "#show" do
    let!(:story) { create :story }

    context "story not found" do
      subject! { get "/lawyer/stories/123213" }
      it { expect(response).to be_redirect }
    end

    context "no score record" do
      subject! { get "/lawyer/stories/#{story.id}" }
      it { expect(response).to be_redirect }
    end

    context "success" do
      let!(:schedule_score) { create :schedule_score, schedule_rater: lawyer, story: story }
      subject! { get "/lawyer/stories/#{story.id}" }
      it { expect(response).to be_success }
    end
  end
end
