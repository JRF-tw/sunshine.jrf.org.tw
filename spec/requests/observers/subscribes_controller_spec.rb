require "rails_helper"

RSpec.describe Observers::SubscribesController, type: :request do
  before { signin_court_observer }

  describe "#create" do
    subject! { post "/observer/stories/xxxx/subscribe" }
    it { expect(response).to be_redirect }
  end
end
