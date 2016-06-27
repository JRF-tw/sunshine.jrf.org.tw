require 'rails_helper'

RSpec.describe Bystander::EmailsController, type: :request do
  before { signin_bystander }

  describe "#edit" do
    before { signin_bystander }
    subject!{ get "/bystander/email/edit" }
    it { expect(response).to be_success }
  end
end
