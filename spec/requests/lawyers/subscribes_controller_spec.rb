require "rails_helper"

RSpec.describe Lawyers::SubscribesController, type: :request do

  let!(:lawyer) { create(:lawyer, :with_password, :with_confirmed) }
  before { signin_lawyer(lawyer) }
  let!(:story) { create :story }

  describe "#toggle" do
    subject! { post "/lawyer/stories/#{story.id}/subscribe/toggle.js" }
    it { expect(StorySubscription.count).to eq(1) }
  end

  describe "#delete" do
    before { post "/lawyer/stories/#{story.id}/subscribe/toggle.js" }
    subject! { delete "/lawyer/stories/#{story.id}/subscribe" }
    it { expect(response).to be_redirect }
    it { expect(StorySubscription.count).to eq(0) }
  end
end
