# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  comment    :text
#  no         :string(255)
#  source     :string(255)
#  file       :string(255)
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

class Review < ActiveRecord::Base
	mount_uploader :file, FileUploader
	
	include TaiwanAge
  tw_age_columns :publish_at

  belongs_to :profile

  scope :newest, ->{ order("id DESC") }
  scope :had_title, -> { where.not(:title => nil) }
end
