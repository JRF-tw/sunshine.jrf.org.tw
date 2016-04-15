# == Schema Information
#
# Table name: judges
#
#  id                 :integer          not null, primary key
#  name               :string
#  current_court_id   :integer
#  avatar             :string
#  gender             :string
#  gender_source      :string
#  birth_year         :integer
#  birth_year_source  :string
#  stage              :integer
#  stage_source       :string
#  appointment        :string
#  appointment_source :string
#  memo               :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Admin::Judge < ::Judge
  has_many :judge_stories
  has_many :stories, through: :judge_stories
  has_many :branches
  belongs_to :court , class_name: "Court", foreign_key: :current_court_id


  GENDER_TYPES = [
    "男",
    "女",
    "其他"
  ]

  validates_presence_of :name
end
