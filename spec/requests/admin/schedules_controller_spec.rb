require 'rails_helper'

RSpec.describe Admin::SchedulesController do
  before { signin_user }

  describe "#index" do
    let!(:schedule) { FactoryGirl.create :schedule, :with_court }

    context "search the branch_name of schedules" do
      before { get "/admin/schedules", q: { branch_name: schedule.branch_name } }
      it {
        expect(response.body).to match(schedule.branch_name)
      }
    end 
  end
  
  describe "already had a schedules" do
    let!(:schedule) { FactoryGirl.create :schedule, :with_court }
    
    it "GET /admin/schedules" do
      get "/admin/schedules"
      expect(response).to be_success
    end
  end

end  