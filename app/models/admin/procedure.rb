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

class Admin::Procedure < Procedure
  belongs_to :profile, class_name: "Admin::Profile"
  belongs_to :suit, class_name: "Admin::Suit"

  validates_presence_of :profile_id, :suit_id, :unit, :title, :procedure_unit, :procedure_content, :procedure_date
end
