# == Schema Information
#
# Table name: banners
#
#  id          :integer          not null, primary key
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
  validates :title, :link, :pic, presence: true

  scope :order_by_weight, -> { order('weight DESC, id DESC') }
end
