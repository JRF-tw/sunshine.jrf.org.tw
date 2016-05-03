# == Schema Information
#
# Table name: lawyer_verdicts
#
#  id         :integer          not null, primary key
#  verdict_id :integer
#  lawyer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LawyerVerdict < ActiveRecord::Base
  belongs_to :lawyer
  belongs_to :verdict
end
