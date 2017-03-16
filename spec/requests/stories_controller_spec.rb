require 'rails_helper'

RSpec.describe StoriesController, type: :request do
  let!(:story) { create :story }

  context '#index' do
    context 'without search query' do
      before { get '/stories' }
      it { expect(response).to be_success }
      it { expect(response.body).not_to match(story.word_type) }
    end

    context 'with search query' do
      before { get '/stories', q: { year_eq: story.year, number_eq: story.number } }
      it { expect(response).to be_success }
      it { expect(response.body).to match(story.word_type) }
    end
  end
end
