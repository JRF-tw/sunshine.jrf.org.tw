# == Schema Information
#
# Table name: verdicts
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Verdict < ActiveRecord::Base
end
