# == Schema Information
#
# Table name: suits
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  summary    :text
#  content    :text
#  state      :string(255)
#  pic        :string(255)
#  suit_no    :integer
#  keyword    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Suit < ActiveRecord::Base
  mount_uploader :pic, SuitPicUploader

  has_many :suit_judges, dependent: :destroy
  has_many :judges, through: :suit_judges
  has_many :suit_prosecutors, dependent: :destroy
  has_many :prosecutors, through: :suit_prosecutors
  has_many :procedures, dependent: :destroy

  scope :newest, ->{ order("id DESC") }

  def related_suits
    judge_ids = self.judges.map(&:id)
    prosecutor_ids = self.prosecutors.map(&:id)
    suit_ids = (SuitJudge.where(profile_id: judge_ids).map(&:suit_id) + SuitProsecutor.where(profile_id: prosecutor_ids).map(&:suit_id)).uniq
    Suit.where(id: suit_ids)
  end

  def procedures_by_person
    profile_ids = self.procedures.map(&:profile_id)
    people = Profile.where(id: profile_ids)
    arr = []
    people.each do |person|
      arr << person.procedures.where(suit_id: self.id).flow_by_procedure_date
    end
    arr
  end

  class << self

    def find_state(state)
      # TODO 確認一下要搜尋什麼欄位
      # return where( state) if state.present?
      all
    end

    def front_like_search(search_word, combination = "or")
      search_word.keep_if {|k, v| v.present? }
      if search_word.present?
        where_str = search_word.map { |k, i| "\"#{self.table_name}\".\"#{k}\" like :#{k}" }.join(" #{combination} ")
        a_search_word = search_word.inject({}) { |hh, (k, v)| hh[k.to_sym] = "%#{v}%"; hh }
        relation = self.where([where_str, a_search_word])
      end
      relation
    end
  end

end
