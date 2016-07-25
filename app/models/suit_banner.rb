# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  url        :string
#  alt_string :string
#  title      :string
#  content    :text
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class SuitBanner < ActiveRecord::Base
  mount_uploader :pic_l, BannerPicLUploader
  mount_uploader :pic_m, BannerPicMUploader
  mount_uploader :pic_s, BannerPicSUploader

  include HiddenOrNot

  scope :order_by_weight, -> { order("weight DESC, id DESC") }
end
