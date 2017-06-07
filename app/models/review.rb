# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string
#  title      :string
#  content    :text
#  comment    :text
#  no         :string
#  source     :text
#  file       :string
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#  owner_id   :integer
#  owner_type :string
#

class Review < ActiveRecord::Base
  mount_uploader :file, FileUploader

  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :publish_at

  belongs_to :owner, polymorphic: true
  validates :owner_id, :owner_type, :name, :title, presence: true

  scope :newest, -> { order('id DESC') }
  scope :order_by_publish_at, -> { order('publish_at DESC, id DESC') }
  scope :had_title, -> { where.not(title: nil) }
end
