require 'rails_helper'

RSpec.describe Lawyers::EdmsController, type: :request do
  before { signin_lawyer }
  describe "#toggle_scbscribe with js" do
    subject! { post "/lawyer/edm/toggle_subscribe.js" }
    it { expect(response).to be_success }
  end
end
