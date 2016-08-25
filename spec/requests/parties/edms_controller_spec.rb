require 'rails_helper'

RSpec.describe Parties::EdmsController, type: :request do
  before { signin_party }
  describe "#toggle_scbscribe with js" do
    subject! { post "/party/edm/toggle_subscribe.js" }
    it { expect(response).to be_success }
  end
end
