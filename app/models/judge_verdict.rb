class JudgeVerdict < ActiveRecord::Base
  belongs_to :judge
  belongs_to :verdict
end
