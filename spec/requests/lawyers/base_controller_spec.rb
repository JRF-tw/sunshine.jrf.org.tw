require 'rails_helper'

RSpec.describe Lawyers::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_lawyer }
      subject!{ get "/lawyers" }
      it { expect(response).to be_success }
    end

  end
end
