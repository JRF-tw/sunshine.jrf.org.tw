# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  award_type  :string(255)
#  unit        :string(255)
#  content     :text
#  publish_at  :date
#  source      :text
#  source_link :string(255)
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#  is_hidden   :boolean
#

class Award < ActiveRecord::Base
	include TaiwanAge
  tw_age_columns :publish_at
  
  belongs_to :profile

  scope :newest, ->{ order("id DESC") }
  scope :order_by_publish_at, ->{ order("publish_at DESC, id DESC") }
end
