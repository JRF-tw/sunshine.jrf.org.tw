require "rails_helper"

RSpec.describe Bystander::SubscribesController, type: :request do
  before { signin_bystander }

  describe "#create" do
    subject! { post "/bystander/stories/xxxx/subscribe" }
    it { expect(response).to be_redirect }
  end
end
