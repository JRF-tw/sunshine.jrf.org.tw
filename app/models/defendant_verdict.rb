# == Schema Information
#
# Table name: defendant_verdicts
#
#  id           :integer          not null, primary key
#  verdict_id   :integer
#  defendant_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DefendantVerdict < ActiveRecord::Base
  belongs_to :defendant
  belongs_to :verdict
end
