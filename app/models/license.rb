# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string
#  unit         :string
#  title        :string
#  publish_at   :date
#  source       :text
#  source_link  :text
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#  is_hidden    :boolean
#  owner_id     :integer
#  owner_type   :string
#

class License < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :publish_at

  belongs_to :owner, polymorphic: true
  belongs_to :profile
  validates :owner_id, :owner_type, :license_type, :unit, :title, presence: true

  scope :newest, -> { order('id DESC') }
  scope :order_by_publish_at, -> { order('publish_at DESC, id DESC') }
end
