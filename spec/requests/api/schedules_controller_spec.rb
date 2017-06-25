require 'rails_helper'

RSpec.describe Api::SchedulesController, type: :request do
  before { host! 'api.example.com' }
  include_context 'create_data_for_request'
  let!(:schedule) { create :schedule, :with_branch_judge, story: story, court: court }
  def index_json
    {
      story: {
        identity: {
          type: story.story_type,
          year: story.year,
          word: story.word_type,
          number: story.number
        },
        reason: story.reason,
        adjudged_on: story.adjudged_on,
        pronounced_on: story.pronounced_on,
        judges_names: story.judges_names,
        prosecutor_names: story.prosecutor_names,
        lawyer_names: story.lawyer_names,
        party_names: story.party_names,
        detail_url: api_story_url(story.court.code, story.identity, protocol: 'https')
      },
      court: {
        name: court.full_name,
        simple_name: court.name,
        code: court.code
      },
      schedules: [{
        branch_name: schedule.branch_name,
        branch_judge: schedule.branch_judge.name,
        courtroom: schedule.courtroom,
        start_on: schedule.start_on.to_s,
        start_at: schedule.start_at.to_s
      }]

    }.deep_stringify_keys
  end

  describe '#index' do
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
