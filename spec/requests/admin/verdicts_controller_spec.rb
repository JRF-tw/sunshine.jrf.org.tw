require 'rails_helper'

RSpec.describe Admin::VerdictsController do
  before{ signin_user }

  describe "#index" do
    let!(:verdict) { FactoryGirl.create :verdict }

    context "search the content of verdicts" do
      before { get "/admin/verdicts", q: { content: "無罪" } }
      it { expect(response.body).to match(verdict.content) }
    end

    context "render success" do
      before { get "/admin/verdicts" }
      it { expect(response).to be_success }
    end
  end  
end
