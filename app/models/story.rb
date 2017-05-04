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
#  is_adjudged      :boolean          default(FALSE)
#  adjudged_on      :date
#  pronounced_on    :date
#  is_pronounced    :boolean          default(FALSE)
#  is_calculated    :boolean          default(FALSE)
#  reason           :string
#  schedules_count  :integer          default(0)
#

class Story < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_one :verdict, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :story_relations, dependent: :destroy
  has_many :parties, through: :story_relations, source: :person, source_type: 'Party'
  has_many :lawyers, through: :story_relations, source: :person, source_type: 'Lawyer'
  has_many :prosecutors, through: :story_relations, source: :person, source_type: 'Prosecutor'
  has_many :judges, through: :story_relations, source: :people, source_type: 'Judge'
  has_many :story_subscriptions, dependent: :destroy
  has_many :verdict_scores
  has_many :schedule_scores
  has_many :valid_scores
  belongs_to :court

  validates :story_type, :year, :word_type, :number, presence: true
  serialize :party_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array

  scope :newest, -> { order('id DESC') }
  scope :search_sort, -> { reorder('adjudged_on DESC NULLS LAST, created_at DESC') }
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
    "#{court.name}#{story_type}案件 #{year}年#{word_type}字第#{number}號"
  end

  def verdict_got_on
    if verdict && verdict.created_at
      verdict.created_at.to_date
    end
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
