require 'rails_helper'

RSpec.describe Party::SubscribesController, type: :request do
  before { signin_party }

  describe "#create" do
    subject!{ post "/party/stories/xxxx/subscribe" }
    it { expect(response).to be_redirect }
  end
end
