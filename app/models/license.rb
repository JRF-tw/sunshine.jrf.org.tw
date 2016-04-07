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
#

class License < ActiveRecord::Base
  include HiddenOrNot
	include TaiwanAge
  tw_age_columns :publish_at
  
  belongs_to :profile

  scope :newest, ->{ order("id DESC") }
  scope :order_by_publish_at, ->{ order("publish_at DESC, id DESC") }
end
