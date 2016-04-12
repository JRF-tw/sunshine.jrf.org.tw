# == Schema Information
#
# Table name: branches
#
#  id           :integer          not null, primary key
#  court_id     :integer
#  judge_id     :integer
#  name         :string
#  chamber_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Branch < ActiveRecord::Base
  belongs_to :court
  belongs_to :judge
end
