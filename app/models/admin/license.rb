# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string
#  unit         :string
#  title        :string
#  publish_at   :date
#  source       :text
#  source_link  :text
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#  is_hidden    :boolean
#

class Admin::License < ::License
  belongs_to :profile, class_name: "Admin::Profile"

  validates :profile_id, :license_type, :unit, :title, presence: true
end
