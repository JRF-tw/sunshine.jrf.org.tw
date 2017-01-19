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

  scope :newest, -> { order(id: :desc) }
  scope :order_by_weight, -> { order('weight IS NULL, weight DESC, id DESC') }
end
