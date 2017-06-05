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
#  owner_id         :integer
#  owner_type       :string
#

class Article < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :paper_publish_at, :news_publish_at

  belongs_to :owner, polymorphic: true
  belongs_to :profile
  validates :owner_id, :owner_type, :article_type, presence: true
  validate :validate_publish_date

  scope :newest, -> { order('id DESC') }

  ARTICLE_TYPES = [
    '編輯專書',
    '期刊文章',
    '會議論文',
    '報紙投書',
    '專書',
    '碩博士論文',
    '報告',
    '其他'
  ].freeze

  private

  def validate_publish_date
    return true if publish_year.present? || paper_publish_at.present? || news_publish_at.present?
    false
  end
end
