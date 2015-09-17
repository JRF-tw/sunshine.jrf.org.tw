# == Schema Information
#
# Table name: judgment_prosecutors
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  judgment_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class JudgmentProsecutor < ActiveRecord::Base
  belongs_to :judgment
  belongs_to :prosecutor, class_name: "Profile", foreign_key: :profile_id
  validates_uniqueness_of :judgment_id, scope: [:profile_id]
end
