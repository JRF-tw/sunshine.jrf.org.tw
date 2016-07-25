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

class Article < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :paper_publish_at, :news_publish_at

  belongs_to :profile

  scope :newest, -> { order("id DESC") }
end
