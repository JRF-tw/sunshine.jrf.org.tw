# == Schema Information
#
# Table name: prosecutors
#
#  id                    :integer          not null, primary key
#  name                  :string
#  prosecutors_office_id :integer
#  judge_id              :integer
#  avatar                :string
#  gender                :string
#  gender_source         :string
#  birth_year            :integer
#  birth_year_source     :string
#  stage                 :integer
#  stage_source          :string
#  appointment           :string
#  appointment_source    :string
#  memo                  :string
#  is_active             :boolean          default(TRUE)
#  is_hidden             :boolean          default(TRUE)
#  is_judge              :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Prosecutor < ActiveRecord::Base
  belongs_to :prosecutors_office
  belongs_to :judge

  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true
end
