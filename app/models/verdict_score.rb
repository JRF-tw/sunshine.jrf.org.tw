# == Schema Information
#
# Table name: verdict_scores
#
#  id                 :integer          not null, primary key
#  story_id           :integer
#  verdict_rater_id   :integer
#  verdict_rater_type :string
#  data               :hstore
#  appeal_judge       :boolean
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  quality_scores     :hstore
#

class VerdictScore < ActiveRecord::Base
  validates :verdict_rater_type, presence: true
  validates :verdict_rater_id, presence: true, uniqueness: { scope: [:verdict_rater_type, :story_id] }
  validates :story_id, presence: true
  store_accessor :data, :court_id, :year, :word_type, :number, :story_type, :note
  store_accessor :quality_score, :score_3_1, :score_3_2_1, :score_3_2_2, :score_3_2_3, :score_3_2_4, :score_3_2_5, :score_3_2_6

  belongs_to :story
  belongs_to :verdict_rater, polymorphic: true
end
