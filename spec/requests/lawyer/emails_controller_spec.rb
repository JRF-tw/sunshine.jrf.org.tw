require 'rails_helper'

RSpec.describe Lawyer::EmailsController, type: :request do
  before { signin_lawyer }

  describe "#edit" do
    subject!{ get "/lawyer/email/edit" }
    it { expect(response).to be_success }
  end
end
