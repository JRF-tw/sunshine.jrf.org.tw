require 'rails_helper'

RSpec.describe Admin::StoriesController do
  before{ signin_user }

  describe "#index" do
    let!(:story1) { FactoryGirl.create :story, story_type: "邢事", year: 1990, word_type: "火箭", number: 100 }

    context "search the story_type of stories" do
      before { get "/admin/stories", q: { story_type: "邢事" } }
      it {
        expect(response.body).to match(story1.story_type)
      }
    end 
  end
  
  describe "already had a stories" do
    let!(:court) { FactoryGirl.create :court }
    
    it "GET /admin/courts" do
      get "/admin/courts"
      expect(response).to be_success
    end
  end  

end
