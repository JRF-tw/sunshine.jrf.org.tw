# == Schema Information
#
# Table name: judge_verdicts
#
#  id         :integer          not null, primary key
#  verdict_id :integer
#  judge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JudgeVerdict < ActiveRecord::Base
  belongs_to :judge
  belongs_to :verdict
end
