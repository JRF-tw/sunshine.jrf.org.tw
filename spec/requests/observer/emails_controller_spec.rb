require "rails_helper"

RSpec.describe Observer::EmailsController, type: :request do
  before { signin_court_observer }

  describe "#edit" do
    subject! { get "/observer/email/edit" }
    it { expect(response).to be_success }
  end
end
