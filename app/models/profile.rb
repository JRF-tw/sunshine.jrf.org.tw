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

class Profile < ActiveRecord::Base
  include HiddenOrNot
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

  scope :newest, -> { order("id DESC") }
  scope :had_avatar, -> { where.not(avatar: nil) }
  scope :active, -> { where.not(is_active: [false, nil]) }
  scope :random, -> { order("RANDOM()") }
  scope :by_punishments, -> { order("punishments_count DESC, name ASC") }
  scope :order_by_name, -> { order("name ASC") }

  def suit_list
    ids = (suit_judges.map(&:suit_id) + suit_prosecutors.map(&:suit_id)).uniq
    Suit.where(id: ids)
  end

  class << self
    def judges
      where(current: "法官")
    end

    def prosecutors
      where(current: "檢察官")
    end

    def justices
      where(current: "大法官")
    end

    def find_current_court(type)
      return where(current_court: type) if type.present? && (Court.where(full_name: type).count > 0)
      all
    end

    def front_like_search(search_word, combination = "or")
      search_word.keep_if { |_k, v| v.present? }
      if search_word.present?
        where_str = search_word.map { |k, _i| "\"#{table_name}\".\"#{k}\" like :#{k}" }.join(" #{combination} ")
        a_search_word = search_word.each_with_object({}) { |array, hash| hash[array.first.to_sym] = "%#{array.last}%" }
        relation = where([where_str, a_search_word])
      else
        relation = all
      end
      relation
    end
  end

end
