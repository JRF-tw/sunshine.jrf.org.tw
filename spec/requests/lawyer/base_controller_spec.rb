require 'rails_helper'

RSpec.describe Lawyer::BaseController, type: :request do
  before { signin_lawyer }

  describe "#index" do
    subject!{ get "/lawyer" }
    it { expect(response).to be_success }
  end
end
