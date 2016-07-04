require "rails_helper"

RSpec.describe Admin::SchedulesController do
  before { signin_user }

  describe "#index" do
    let!(:schedule) { FactoryGirl.create :schedule }

    context "search the branch_name of schedules" do
      before { get "/admin/schedules", q: { branch_name: schedule.branch_name } }
      it { expect(response.body).to match(schedule.branch_name) }
    end

    context "search the main_judge of schedules" do
      before { get "/admin/schedules", q: { main_judge_id_eq: schedule.story.main_judge.id } }
      it { expect(response.body).to match(schedule.branch_name) }
    end

    context "search the story_id of schedules" do
      before { get "/admin/schedules", q: { story_id_eq: schedule.story.id } }
      it { expect(response.body).to match(schedule.story.identity) }
    end

    context "render success" do
      before { get "/admin/schedules" }
      it { expect(response).to be_success }
    end
  end

  describe "#show" do
    let!(:schedule) { FactoryGirl.create :schedule }
    before { get "/admin/schedules/#{schedule.id}" }
    it { expect(response).to be_success }
  end

end
