require 'rails_helper'

RSpec.describe Defendants::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_defendant }
      subject!{ get "/defendants" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/defendants" }
      it { expect(response).to be_redirect }
    end
  end
end
