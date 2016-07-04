# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  award_type  :string
#  unit        :string
#  content     :text
#  publish_at  :date
#  source      :text
#  source_link :text
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#  is_hidden   :boolean
#

class Admin::Award < ::Award
  belongs_to :profile, class_name: "Admin::Profile"

  validates :profile_id, :award_type, :unit, :publish_at_in_tw, presence: true
end
