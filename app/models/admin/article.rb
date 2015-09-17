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

class Admin::Article < ::Article
  belongs_to :profile, class_name: "Admin::Profile"
  
  validates_presence_of :profile_id, :article_type
  validate :validate_publish_date

  private

  def validate_publish_date
    return true if publish_year.present? || paper_publish_at.present? || news_publish_at.present?
    false
  end
end
