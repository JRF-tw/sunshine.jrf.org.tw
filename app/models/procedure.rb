# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string(255)
#  title             :string(255)
#  procedure_unit    :string(255)
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string(255)
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :string(255)
#  punish_link       :string(255)
#  file              :string(255)
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#

class Procedure < ActiveRecord::Base
	mount_uploader :file, FileUploader
	
	include TaiwanAge
  tw_age_columns :procedure_date

  belongs_to :profile
  belongs_to :suit

  scope :newest, ->{ order("id DESC") }
  scope :sort_by_procedure_date, ->{ order("procedure_date DESC") }
  scope :flow_by_procedure_date, ->{ order("procedure_date ASC") }
  scope :is_done, ->{ where(procedure_content: "結束") }

end
