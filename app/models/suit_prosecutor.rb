# == Schema Information
#
# Table name: suit_prosecutors
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class SuitProsecutor < ActiveRecord::Base
  belongs_to :suit
  belongs_to :prosecutor, :class_name => "Profile", :foreign_key => :profile_id
  validates_uniqueness_of :suit_id, :scope => [:profile_id]
end
