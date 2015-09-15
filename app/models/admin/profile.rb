# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  current            :string(255)
#  avatar             :string(255)
#  gender             :string(255)
#  gender_source      :string(255)
#  birth_year         :integer
#  birth_year_source  :string(255)
#  stage              :integer
#  stage_source       :string(255)
#  appointment        :string(255)
#  appointment_source :string(255)
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#

class Admin::Profile < ::Profile

  has_many :educations, :class_name => "Admin::Education", :dependent => :destroy
  has_many :careers, :class_name => "Admin::Career", :dependent => :destroy
  has_many :licenses, :class_name => "Admin::License", :dependent => :destroy
  has_many :awards, :class_name => "Admin::Award", :dependent => :destroy
  has_many :punishments, :class_name => "Admin::Punishment", :dependent => :destroy
  has_many :reviews, :class_name => "Admin::Review", :dependent => :destroy
  has_many :articles, :class_name => "Admin::Article", :dependent => :destroy
  has_many :judgment_judges, :dependent => :destroy
  has_many :judgments, :class_name => "Admin::Judgment", :through => :judgment_judges
  has_many :judgment_prosecutors, :dependent => :destroy
  has_many :judgments, :class_name => "Admin::Judgment", :through => :judgment_prosecutors
  has_many :suit_judges, :dependent => :destroy
  has_many :suits, :class_name => "Admin::Suit", :through => :suit_judges
  has_many :suit_prosecutors, :dependent => :destroy
  has_many :suits, :class_name => "Admin::Suit", :through => :suit_prosecutors
  has_many :procedures, :class_name => "Admin::Procedure", :dependent => :destroy

  CURRENT_TYPES = [
    "法官",
    "檢察官"
  ]

  GENDER_TYPES = [
    "男",
    "女",
    "其他"
  ]

  validates_presence_of :name, :current
end
