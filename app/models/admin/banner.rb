# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Admin::Banner < ::Banner
end
