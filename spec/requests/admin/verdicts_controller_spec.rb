require "rails_helper"

RSpec.describe Admin::VerdictsController do
  before { signin_user }

  describe "#index" do
    let!(:verdict) { FactoryGirl.create :verdict, :with_main_judge }

    context "render success" do
      before { get "/admin/verdicts" }
      it { expect(response).to be_success }
    end

    context "search the adjudge_date" do
      before { get "/admin/verdicts", q: { adjudge_date_eq: verdict.adjudge_date } }
      it { expect(response.body).to match(verdict.story.court.full_name) }
    end

    context "search the main_judge_name" do
      before { get "/admin/verdicts", q: { main_judge_id_eq: verdict.main_judge.id } }
      it { expect(response.body).to match(verdict.main_judge.name) }
    end

    context "search unexist_judges_names" do
      let!(:verdict1) { FactoryGirl.create :verdict, judges_names: ["xxxx"] }
      before { get "/admin/verdicts", q: { unexist_judges_names: 1 } }
      it { expect(response.body).to match(verdict.story.court.full_name) }
      it { expect(response.body).not_to match(verdict1.judges_names.first) }
    end

    context "search is_judgment" do
      context "true" do
        let!(:verdict1) { FactoryGirl.create :verdict, is_judgment: true }
        before { get "/admin/verdicts", q: { is_judgment_true: true } }
        it { expect(response.body).to match(verdict.main_judge.name) }
      end

      context "false" do
        let!(:verdict1) { FactoryGirl.create :verdict, is_judgment: false }
        before { get "/admin/verdicts", q: { is_judgment_true: false } }
        it { expect(response.body).to match(verdict.main_judge.name) }
      end
    end
  end

  describe "#show" do
    let!(:verdict) { FactoryGirl.create :verdict }
    before { get "/admin/verdicts/#{verdict.id}" }

    it { expect(response).to be_success }
  end

  describe "#download_file" do
    let!(:verdict) { FactoryGirl.create :verdict, :with_file }

    context "search the content of verdicts" do
      before { get "/admin/verdicts/#{verdict.id}/download_file" }
      it { expect(response).to be_success }
    end
  end
end
