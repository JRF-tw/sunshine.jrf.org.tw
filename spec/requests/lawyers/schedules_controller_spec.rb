require 'rails_helper'

RSpec.describe Lawyers::SchedulesController, type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  before { signin_lawyer(lawyer) }

  context 'score flow' do
    let!(:story) { create :story, court: court }
    let!(:schedule) { create :schedule, story: story }
    let!(:judge) { create :judge, court: court }

    describe '#new' do
      subject! { get '/lawyer/score/schedules/new' }
      it { expect(response).to be_success }
    end

    describe '#input_info' do
      subject! { get '/lawyer/score/schedules/input_info' }
      it { expect(response).to be_success }
    end

    describe '#check_info' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type } }
        subject! { post '/lawyer/score/schedules/check_info', schedule_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/schedules/check_info', schedule_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end

    describe '#input_date' do
      subject! { get '/lawyer/score/schedules/input_date' }
      it { expect(response).to be_success }
    end

    describe '#check_date' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, start_on: schedule.start_on, confirmed_realdate: false } }
        subject! { post '/lawyer/score/schedules/check_date', schedule_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/schedules/check_date', schedule_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end

    describe '#input_judge' do
      subject! { get '/lawyer/score/schedules/input_judge' }
      it { expect(response).to be_success }
    end

    describe '#check_judge' do
      context 'success' do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name } }
        subject! { post '/lawyer/score/schedules/check_judge', schedule_score: params }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/schedules/check_judge', schedule_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end

    describe '#create' do
      context 'success' do
        let!(:params) { attributes_for(:schedule_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name) }
        subject! { post '/lawyer/score/schedules', schedule_score: params }
        it { expect(response).to be_success }
        it { expect(flash[:error]).to be_nil }
      end

      context 'error params' do
        subject! { post '/lawyer/score/schedules', schedule_score: {} }
        it { expect(response).to be_redirect }
        it { expect(flash[:error]).to eq('選擇法院不存在') }
      end
    end
  end

  describe '#rule' do
    subject! { get '/lawyer/score/schedules/rule' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    let!(:schedule_score) { create :schedule_score, schedule_rater: lawyer, court_id: court.id }
    subject! { get "/lawyer/score/schedules/#{schedule_score.id}/edit" }

    it { expect(response).to be_success }
  end

  describe '#update' do
    let!(:schedule_score) { create :schedule_score, schedule_rater: lawyer, court_id: court.id }
    let!(:params) { attributes_for(:schedule_score_for_update_params) }
    subject! { put "/lawyer/score/schedules/#{schedule_score.id}", schedule_score: params }

    it { expect(response).to be_success }
  end
end
