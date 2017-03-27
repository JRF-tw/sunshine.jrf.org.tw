# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudge       :boolean          default(FALSE)
#  adjudge_date     :date
#  pronounce_date   :date
#  is_pronounce     :boolean          default(FALSE)
#  is_calculated    :boolean          default(FALSE)
#

class Story < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_one :verdict, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :story_relations, dependent: :destroy
  has_many :judges, through: :story_relations, source: :people, source_type: :Judge
  has_many :story_subscriptions, dependent: :destroy
  has_many :verdict_scores
  has_many :schedule_scores
  has_many :valid_scores
  belongs_to :court

  serialize :party_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array

  scope :newest, -> { order('id DESC') }
  scope :not_caculate, -> { where(is_calculated: false) }

  include Redis::Objects
  counter :lawyer_scored_count
  counter :party_scored_count

  MAX_PARTY_SCORED_COUNT = 3
  MAX_LAWYER_SCORED_COUNT = 5

  def identity
    "#{story_type}-#{year}-#{word_type}-#{number}"
  end

  def by_relation_role(role)
    type = role.singularize.camelize
    story_relations.where(people_type: type)
  end

  def detail_info
    "#{court.full_name}#{year}年#{word_type}字第#{number}號"
  end

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:relation_by_judge]
    end

    def relation_by_judge(judge_id)
      relations_story_ids = Judge.find(judge_id).story_relations.pluck(:story_id)
      where(id: relations_story_ids)
    end
  end
end
