require "rails_helper"

RSpec.describe JudgesController, type: :request do

  describe "#edit" do
    subject! { get "/judges/xxxx" }
    it { expect(response).to be_success }
  end

end
