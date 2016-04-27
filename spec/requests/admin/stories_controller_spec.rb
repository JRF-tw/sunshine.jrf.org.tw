require 'rails_helper'

RSpec.describe Admin::StoriesController do
  before{ signin_user }

  describe "#index" do
    let!(:story) { FactoryGirl.create :story, story_type: "邢事", year: 1990, word_type: "火箭", number: 100 }

    context "search the story_type of stories" do
      before { get "/admin/stories", q: { story_type: "邢事" } }
      it { expect(response.body).to match(story.story_type) }
    end

    context "search the main_judge of stories" do
      before { get "/admin/stories", q: { main_judge_id_eq: story.main_judge.id} }
      it { expect(response.body).to match(story.word_type) }
    end

    context "render success" do
      before { get "/admin/stories" }
      it { expect(response).to be_success }
    end
  end  
end
