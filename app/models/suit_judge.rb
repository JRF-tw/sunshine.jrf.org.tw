# == Schema Information
#
# Table name: suit_judges
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class SuitJudge < ActiveRecord::Base
  belongs_to :suit
  belongs_to :judge, class_name: "Profile", foreign_key: :profile_id
  validates :suit_id, uniqueness: { scope: [:profile_id] }
end
