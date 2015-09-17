# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string(255)
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :string(255)
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

class Admin::Education < ::Education
	belongs_to :profile, class_name: "Admin::Profile"
  
  validates_presence_of :profile_id, :title
end
