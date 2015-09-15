# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  article_type     :string(255)
#  publish_year     :integer
#  paper_publish_at :date
#  news_publish_at  :date
#  book_title       :string(255)
#  title            :string(255)
#  journal_no       :string(255)
#  journal_periods  :string(255)
#  start_page       :integer
#  end_page         :integer
#  editor           :string(255)
#  author           :string(255)
#  publisher        :string(255)
#  publish_locat    :string(255)
#  department       :string(255)
#  degree           :string(255)
#  source           :string(255)
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:article){ FactoryGirl.create :article }

  it "FactoryGirl" do
    expect(article).not_to be_new_record
  end

  it "has_many :awards, :dependent => :destroy" do
    expect(Article.count).to eq(1)
    profile = article.profile
    profile.destroy
    expect(Article.count).to be_zero
  end

  context "TaiwanAge" do
    it "#paper_publish_at" do
      a = Article.new
      a.paper_publish_at_in_tw = "104/9/9"
      expect( a.paper_publish_at.year ).to eq 2015
      expect( a.paper_publish_at.month ).to eq 9
      expect( a.paper_publish_at.day ).to eq 9
      expect( a.paper_publish_at_in_tw ).to eq "104/9/9"
    end
  end
end
