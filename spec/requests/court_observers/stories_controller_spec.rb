require 'rails_helper'

RSpec.describe CourtObservers::StoriesController, type: :request do
  let!(:court_observer) { create :court_observer }
  before { signin_court_observer(court_observer) }

  describe '#index root_path' do
    subject! { get '/observer' }
    it { expect(response).to be_success }
  end

  describe '#show' do
    let!(:story) { create :story }

    context 'story not found' do
      subject! { get '/observer/stories/123213' }
      it { expect(response).to be_redirect }
    end

    context 'no score record' do
      subject! { get "/observer/stories/#{story.id}" }
      it { expect(response).to be_redirect }
    end

    context 'success' do
      let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, story: story }
      subject! { get "/observer/stories/#{story.id}" }
      it { expect(response).to be_success }
    end

    context 'story without schedule' do
      let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, story: story, data: { start_on: '2016-09-13' } }
      subject! { get "/observer/stories/#{story.id}" }
      it { expect(response.body).to match('2016-09-13') }
    end
  end
end
