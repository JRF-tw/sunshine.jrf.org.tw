require 'rails_helper'

RSpec.describe Admin::VerdictsController do
  before{ signin_user }

  describe "#index" do
    let!(:verdict) { FactoryGirl.create :verdict }

    context "render success" do
      before { get "/admin/verdicts" }
      it { expect(response).to be_success }
    end

    context "search the adjudge_date of stories" do
      before { get "/admin/verdicts", q: { adjudge_date_eq: verdict.adjudge_date} }
      it { expect(response.body).to match(verdict.story.court.full_name) }
    end
  end

  describe "#download_file" do
    let!(:verdict) { FactoryGirl.create :verdict, :with_file }

    context "search the content of verdicts" do
      before { get "/admin/verdicts/#{verdict.id}/download_file" }
      it { expect(response).to be_success }
    end
  end
end
