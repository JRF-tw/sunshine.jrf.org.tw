require 'rails_helper'

describe CourtObserver::CheckScheduleScoreInfoContext do
  let!(:court_observer) { create :court_observer }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type } }

  describe '#perform' do
    subject { described_class.new(court_observer).perform(params) }

    context 'success' do
      it { expect(subject).to be_truthy }
    end

    context 'court id invalid' do
      before { params[:court_id] = court.id + 1 }
      it { expect(subject).to be_falsey }
    end

    context 'year empty' do
      before { params[:year] = '' }
      it { expect(subject).to be_falsey }
    end

    context 'word_type empty' do
      before { params[:word_type] = '' }
      it { expect(subject).to be_falsey }
    end

    context 'number empty' do
      before { params[:number] = '' }
      it { expect(subject).to be_falsey }
    end

    context 'wrong info not found story' do
      before { params[:word_type] = 'xxx' }
      it { expect(subject).to be_falsey }
    end

    context 'story has pronounced_on?' do
      context 'today pronounced ' do
        before { story.update_attributes(pronounced_on: Time.zone.today) }
        it { expect(subject).to be_truthy }
      end

      context 'yesterday pronounced ' do
        before { story.update_attributes(pronounced_on: Time.zone.today - 1.day) }
        it { expect(subject).to be_falsey }
      end

      context 'will pronounced ' do
        before { story.update_attributes(pronounced_on: Time.zone.today + 1.day) }
        it { expect(subject).to be_truthy }
      end
    end

    context 'story already_adjudge' do
      before { story.update_attributes(adjudged_on: Time.zone.today, is_adjudge: true) }
      it { expect(subject).to be_falsey }
    end
  end
end
