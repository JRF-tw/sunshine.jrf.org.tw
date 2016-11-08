require 'rails_helper'

RSpec.describe Parties::SubscribesController, type: :request do

  let!(:party) { create :party, :already_confirmed }
  before { signin_party(party) }
  let!(:story) { create :story }

  describe '#toggle' do
    subject! { post "/party/stories/#{story.id}/subscribe/toggle.js" }
    it { expect(StorySubscription.count).to eq(1) }
  end

  describe '#delete' do
    before { post "/party/stories/#{story.id}/subscribe/toggle.js" }
    subject! { get "/party/stories/#{story.id}/subscribe", token: party.unsubscribe_token }
    it { expect(response).to be_redirect }
    it { expect(StorySubscription.count).to eq(0) }
  end
end
