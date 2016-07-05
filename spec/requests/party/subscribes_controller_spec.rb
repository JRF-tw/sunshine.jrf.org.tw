require "rails_helper"

RSpec.describe Party::SubscribesController, type: :request do

  let!(:party) { FactoryGirl.create :party, :already_confirmed }
  before { signin_party(party) }
  let!(:story) { FactoryGirl.create :story }
  
  describe "#create" do
    subject!{ post "/party/stories/#{story.id}/subscribe" }
    it { expect(response).to be_redirect }
    it { expect(StorySubscription.count).to eq(1) }
  end

  describe "#delete" do
    before{ post "/party/stories/#{story.id}/subscribe" }
    subject!{ delete "/party/stories/#{story.id}/subscribe" }
    it { expect(response).to be_redirect }
    it { expect(StorySubscription.count).to eq(0) }
  end
end
