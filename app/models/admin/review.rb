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
#

class Admin::Review < ::Review	
  belongs_to :profile, class_name: "Admin::Profile"

  validates_presence_of :profile_id, :name, :title
end
