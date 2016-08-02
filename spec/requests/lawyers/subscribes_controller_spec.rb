require "rails_helper"

RSpec.describe Lawyers::SubscribesController, type: :request do
  before { signin_lawyer }

  describe "#create" do
    subject! { post "/lawyer/stories/xxxx/subscribe" }
    it { expect(response).to be_redirect }
  end
end
