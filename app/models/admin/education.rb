# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :text
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

class Admin::Education < ::Education
	belongs_to :profile, class_name: "Admin::Profile"
  
  validates_presence_of :profile_id, :title
end
