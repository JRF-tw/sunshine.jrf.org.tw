# == Schema Information
#
# Table name: banners
#
#  id          :integer          not null, primary key
#  pic_l       :string
#  pic_m       :string
#  pic_s       :string
#  weight      :integer
#  is_hidden   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string
#  link        :string
#  btn_wording :string
#  pic         :string
#  desc        :string
#

class Banner < ActiveRecord::Base
  include HiddenOrNot
  mount_uploader :pic, BannerPicUploader
  mount_uploader :pic_l, BannerPicLUploader
  mount_uploader :pic_m, BannerPicMUploader
  mount_uploader :pic_s, BannerPicSUploader
  # validates :title, :link, :pic, presence: true

  scope :order_by_weight, -> { order('weight DESC, id DESC') }
end
