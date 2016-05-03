class DefendantVerdict < ActiveRecord::Base
  belongs_to :defendant
  belongs_to :verdict
end
