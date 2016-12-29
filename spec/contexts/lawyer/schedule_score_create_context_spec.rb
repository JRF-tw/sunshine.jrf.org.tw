require 'rails_helper'

describe Lawyer::ScheduleScoreCreateContext do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { attributes_for(:schedule_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name) }

  describe '#perform' do
    subject { described_class.new(lawyer).perform(params) }

    context 'success' do
      it { expect(subject).to be_truthy }
      it { expect(subject.schedule_rater).to eq(lawyer) }
      it { expect { subject }.to change { ScheduleScore.count } }

      context 'assign_attribute' do
        it { expect(subject.schedule).to eq(schedule) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context 'command_score empty' do
      before { params[:score_2_5] = '' }
      it { expect(subject).to be_falsey }
    end

    context 'attitude_score empty' do
      before { params[:score_1_2] = '' }
      it { expect(subject).to be_falsey }
    end

    context "can't found judge" do
      before { params[:judge_name] = '錯誤法官' }
      it { expect(subject).to be_falsey }
    end

    context 'judge not in in court' do
      before { params[:judge_name] = judge2.name }
      it { expect(subject).to be_falsey }
    end

    describe '#auto_subscribe_story' do
      before { create_list :verdict_score, 2, story: story }
      before { create_list :schedule_score, 3, story: story }
      it { expect { subject }.to change { StorySubscription.count }.by(1) }

      context 'already subscribe' do
        let!(:story_subscription) { create :story_subscription, story: story, subscriber: lawyer }
        it { expect { subject }.to_not change { StorySubscription.count } }
      end
    end

    describe '#alert_story_by_lawyer_scored_count' do
      before { create_list :verdict_score, 2, story: story }
      before { create_list :schedule_score, 3, story: story }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    describe '#alert_lawyer_scored_story_count' do
      before { create_list :verdict_score, 2, verdict_rater: lawyer }
      before { create_list :schedule_score, 3, schedule_rater: lawyer }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
