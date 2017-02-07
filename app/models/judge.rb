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
#  is_active          :boolean          default(TRUE)
#  is_hidden          :boolean          default(TRUE)
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_prosecutor      :boolean          default(FALSE)
#

class Judge < ActiveRecord::Base
  include HiddenOrNot
  include ProfileData

  has_many :branches
  has_many :current_branches, -> { where(missed: false) }, class_name: 'Branch'
  belongs_to :court, foreign_key: :current_court_id
  has_many :schedules, foreign_key: 'branch_judge_id'
  has_many :story_relations, as: :people, dependent: :destroy
  has_many :stories, through: :story_relations, as: :people
  has_many :verdict_relations, as: :person, dependent: :destroy
  has_many :verdicts, through: :verdict_relations
  has_many :rule_relations, as: :person, dependent: :destroy
  has_many :rules, through: :rule_relations
  has_many :schedule_scores
  has_many :valid_scores
  has_one :prosecutor

  mount_uploader :avatar, AvatarUploader

end
