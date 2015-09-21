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
#  current_court      :string(255)
#

class Profile < ActiveRecord::Base
  mount_uploader :avatar, ProfileAvatarUploader

  has_many :educations, dependent: :destroy
  has_many :careers, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :awards, dependent: :destroy
  has_many :punishments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :judgment_judges, dependent: :destroy
  has_many :judgments, through: :judgment_judges
  has_many :judgment_prosecutors, dependent: :destroy
  has_many :judgments, through: :judgment_prosecutors
  has_many :suit_judges, dependent: :destroy
  has_many :suits, through: :suit_judges
  has_many :suit_prosecutors, dependent: :destroy
  has_many :suits, through: :suit_prosecutors
  has_many :procedures, dependent: :destroy

  scope :newest, ->{ order("id DESC") }
  scope :had_avatar, -> { where.not(:avatar => nil) }

  def self.judges
    where(current: "法官")
  end

  def self.prosecutors
    where(current: "檢察官")
  end

  def suit_list
    ids = (self.suit_judges.map(&:suit_id) + self.suit_prosecutors.map(&:suit_id)).uniq
    Suit.where(id: ids)
  end
  
end
