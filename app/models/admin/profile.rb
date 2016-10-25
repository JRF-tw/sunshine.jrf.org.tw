# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string
#  current            :string
#  avatar             :string
#  gender             :string
#  gender_source      :text
#  birth_year         :integer
#  birth_year_source  :text
#  stage              :integer
#  stage_source       :text
#  appointment        :string
#  appointment_source :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  current_court      :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  current_department :string
#  current_branch     :string
#

class Admin::Profile < ::Profile

  has_many :educations, class_name: 'Admin::Education', dependent: :destroy
  has_many :careers, class_name: 'Admin::Career', dependent: :destroy
  has_many :licenses, class_name: 'Admin::License', dependent: :destroy
  has_many :awards, class_name: 'Admin::Award', dependent: :destroy
  has_many :punishments, class_name: 'Admin::Punishment', dependent: :destroy
  has_many :reviews, class_name: 'Admin::Review', dependent: :destroy
  has_many :articles, class_name: 'Admin::Article', dependent: :destroy
  has_many :judgment_judges, dependent: :destroy
  has_many :judgments, class_name: 'Admin::Judgment', through: :judgment_judges
  has_many :judgment_prosecutors, dependent: :destroy
  has_many :judgments, class_name: 'Admin::Judgment', through: :judgment_prosecutors
  has_many :suit_judges, dependent: :destroy
  has_many :suits, class_name: 'Admin::Suit', through: :suit_judges
  has_many :suit_prosecutors, dependent: :destroy
  has_many :suits, class_name: 'Admin::Suit', through: :suit_prosecutors
  has_many :procedures, class_name: 'Admin::Procedure', dependent: :destroy

  CURRENT_TYPES = [
    '法官',
    '檢察官',
    '大法官',
    '其他'
  ].freeze

  validates :name, :current, presence: true
end
