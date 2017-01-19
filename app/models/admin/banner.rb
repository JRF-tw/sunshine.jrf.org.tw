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

class Admin::Banner < ::Banner
end
