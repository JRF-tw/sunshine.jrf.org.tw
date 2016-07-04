# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string
#  title             :string
#  procedure_unit    :string
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :text
#  punish_link       :string
#  file              :string
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#  is_hidden         :boolean
#

class Procedure < ActiveRecord::Base
  mount_uploader :file, FileUploader

  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :procedure_date

  belongs_to :profile
  belongs_to :suit, counter_cache: :procedure_count

  scope :newest, -> { order("id DESC") }
  scope :sort_by_procedure_date, -> { order("procedure_date DESC") }
  scope :flow_by_procedure_date, -> { order("procedure_date ASC") }
  scope :is_done, -> { where(procedure_content: "結束") }

end
