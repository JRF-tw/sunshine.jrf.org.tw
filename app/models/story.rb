# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  main_judge_id    :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudge       :boolean          default(FALSE)
#  adjudge_date     :date
#

class Story < ActiveRecord::Base
  has_many :schedules
  has_many :verdicts
  has_many :story_relations
  belongs_to :main_judge, class_name: "Judge", foreign_key: "main_judge_id"
  belongs_to :court

  serialize :defendant_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array

  scope :newest, ->{ order("id DESC") }

  def identity
    "#{year}-#{word_type}-#{number}"
  end

  def judgment_verdict
    verdicts.find_by_is_judgment(true)
  end

  def by_relation_judges
    story_relations.where(people_type: "Judge")
  end

  def by_relation_lawyers
    story_relations.where(people_type: "Lawyer")
  end

  def by_relation_defendants
    story_relations.where(people_type: "Defendant")
  end
end
