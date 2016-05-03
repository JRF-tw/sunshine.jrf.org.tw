class LawyerVerdict < ActiveRecord::Base
  belongs_to :lawyer
  belongs_to :verdict
end
