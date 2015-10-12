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
#  is_hidden        :boolean
#

class Article < ActiveRecord::Base
	include HiddenOrNot
  include TaiwanAge
  tw_age_columns :paper_publish_at, :news_publish_at
  
  belongs_to :profile

  scope :newest, ->{ order("id DESC") }
end
