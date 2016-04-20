# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_judgment      :boolean
#

class Verdict < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  serialize :defendant_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array

  belongs_to :story
end
