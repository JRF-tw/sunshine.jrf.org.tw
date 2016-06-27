require 'rails_helper'

RSpec.describe Bystander::BaseController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#index" do

    context "log in" do
      before { signin_bystander }
      subject! { get "/bystander" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/bystander" }
      it { expect(response).to be_redirect }
    end
  end

end
