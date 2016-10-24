# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  article_type     :string
#  publish_year     :integer
#  paper_publish_at :date
#  news_publish_at  :date
#  book_title       :string
#  title            :string
#  journal_no       :string
#  journal_periods  :string
#  start_page       :integer
#  end_page         :integer
#  editor           :string
#  author           :string
#  publisher        :string
#  publish_locat    :string
#  department       :string
#  degree           :string
#  source           :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#  is_hidden        :boolean
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:article) { create :article }

  it 'FactoryGirl' do
    expect(article).not_to be_new_record
  end

  it 'has_many :awards, dependent: :destroy' do
    expect(Article.count).to eq(1)
    profile = article.profile
    profile.destroy
    expect(Article.count).to be_zero
  end

  context 'TaiwanAge' do
    describe '#paper_publish_at' do
      let(:a) { Article.new }
      it 'normal date' do
        a.paper_publish_at_in_tw = '104/9/29'
        expect(a.paper_publish_at.year).to eq 2015
        expect(a.paper_publish_at.month).to eq 9
        expect(a.paper_publish_at.day).to eq 29
        expect(a.paper_publish_at_in_tw).to eq '104/9/29'
      end

      it '民國潤年' do
        a.paper_publish_at_in_tw = '101/2/29'
        expect(a.paper_publish_at.year).to eq 2012
        expect(a.paper_publish_at.month).to eq 2
        expect(a.paper_publish_at.day).to eq 29
        expect(a.paper_publish_at_in_tw).to eq '101/2/29'
      end

      it '西元潤年' do
        a.paper_publish_at_in_tw = '2012/2/29'
        expect(a.paper_publish_at.year).to eq 2012
        expect(a.paper_publish_at.month).to eq 2
        expect(a.paper_publish_at.day).to eq 29
        expect(a.paper_publish_at_in_tw).to eq '101/2/29'
      end

      it '非民國潤年' do
        a.paper_publish_at_in_tw = '102/2/29'
        expect(a.paper_publish_at.year).to eq 2013
        expect(a.paper_publish_at.month).to eq 2
        expect(a.paper_publish_at.day).to eq 28
        expect(a.paper_publish_at_in_tw).to eq '102/2/28'
      end

      it '非西元潤年' do
        a.paper_publish_at_in_tw = '2013/2/29'
        expect(a.paper_publish_at.year).to eq 2013
        expect(a.paper_publish_at.month).to eq 2
        expect(a.paper_publish_at.day).to eq 28
        expect(a.paper_publish_at_in_tw).to eq '102/2/28'
      end
    end

    it 'paper_publish_at = nil' do
      article.update_attributes paper_publish_at_in_tw: '104/9/9'
      expect(article.paper_publish_at.nil?).to be_falsey
      expect {
        article.paper_publish_at_in_tw = nil
        article.save
      }.to change { article.paper_publish_at }
      expect(article.paper_publish_at).to be_nil
    end
  end
end
