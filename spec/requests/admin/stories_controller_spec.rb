require 'rails_helper'

RSpec.describe Admin::StoriesController do
  before { signin_user }
  let(:court) { create :court, full_name: '不理不理法院' }
  let!(:story) { create :story, :pronounced, story_type: '邢事', year: 1990, word_type: '火箭', number: 100 }
  let!(:story_with_verdict) { create :story, :with_verdict, :pronounced, story_type: '民事', year: 1990, word_type: '隊', number: 100, court: court, is_adjudge: true }
  let!(:story_without_verdict) { create :story, story_type: '民事', year: 1990, word_type: '風', number: 100, court: court }
  let!(:story_relation) { create :story_relation, story: story }
  describe '#index' do
    context 'search the story_type of stories' do
      before { get '/admin/stories', q: { story_type: '邢事' } }
      it { expect(response.body).to match(story.story_type) }
    end

    context 'search the adjudge_date of stories' do
      before { get '/admin/stories', q: { adjudge_date_eq: story.adjudge_date } }
      it { expect(response.body).to match(story.word_type) }
    end

    context 'search the is_pronounce of stories' do
      before { get '/admin/stories', q: { is_pronounce_eq: true } }
      it { expect(response.body).to match(story.word_type) }
    end

    context 'search the is_pronounce and court of stories' do
      before { get '/admin/stories', q: { is_pronounce_eq: true, court_id_eq: court.id } }
      it { expect(response.body).to match(story_with_verdict.word_type) }
    end

    context 'search the is_pronounce and adjudge_date of stories' do
      before { get '/admin/stories', q: { is_pronounce_eq: true, adjudge_date_eq: story_with_verdict.adjudge_date } }
      it { expect(response.body).to match(story_with_verdict.word_type) }
    end

    context 'search the is_adjudge_eq true' do
      before { get '/admin/stories', q: { is_adjudge_eq: true } }
      it { expect(response.body).to match(story_with_verdict.word_type) }
    end

    context 'search the is_adjudge_eq false' do
      before { get '/admin/stories', q: { is_adjudge_eq: false } }
      it { expect(response.body).to match(story_without_verdict.word_type) }
      it { expect(response.body).not_to match(story_with_verdict.word_type) }
    end

    context 'search the judge of stories' do
      before { get '/admin/stories', q: { relation_by_judge: Judge.last.id } }
      it { expect(response.body).to match(story.word_type) }
    end

    context 'render success' do
      before { get '/admin/stories' }
      it { expect(response).to be_success }
    end
  end

  context '#show' do
    before { get "/admin/stories/#{story.id}" }
    it { expect(response).to be_success }
  end

end
