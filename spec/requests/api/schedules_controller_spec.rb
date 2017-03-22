require 'rails_helper'

RSpec.describe Api::SchedulesController, type: :request do
  before { host! 'api.example.com' }
  include_context 'create_data_for_request'
  let!(:schedule) { create :schedule, :with_branch_judge, story: story, court: court }
  def index_json
    {
      schedules: [{
        story_identity: story.identity,
        court_name: court.full_name,
        court_code: court.code,
        branch_name: schedule.branch_name,
        branch_judge: schedule.branch_judge.name,
        courtroom: schedule.courtroom,
        start_on: schedule.start_on.to_s,
        start_at: schedule.start_at.to_s
      }]

    }.deep_stringify_keys
  end

  describe '#show' do
    context 'success' do
      let(:url) { URI.encode("/#{code}/#{story.identity}/schedules") }
      subject! { get url }
      it { expect(response_body).to eq(index_json) }
      it { expect(response).to be_success }
    end

    context 'court not exist' do
      let(:url) { URI.encode("/XxX/#{story.identity}/schedules") }
      subject! { get url }
      it { expect(response_body['message']).to eq('該法院代號不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'story not exist' do
      let(:url) { URI.encode("/#{code}/#{story.identity + '1'}/schedules") }
      subject! { get url }
      it { expect(response_body['message']).to eq('案件不存在') }
      it { expect(response.status).to eq(404) }
    end

    context 'schedule not exist' do
      before { Schedule.destroy_all }
      let(:url) { URI.encode("/#{code}/#{story.identity}/schedules") }
      subject! { get url }
      it { expect(response_body['schedules']).to eq([]) }
      it { expect(response).to be_success }
    end
  end
end
