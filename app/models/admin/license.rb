# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string(255)
#  unit         :string(255)
#  title        :string(255)
#  publish_at   :date
#  source       :text
#  source_link  :string(255)
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#  is_hidden    :boolean
#

class Admin::License < ::License  
  belongs_to :profile, class_name: "Admin::Profile"

  validates_presence_of :profile_id, :license_type, :unit, :title
end
