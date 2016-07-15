# == Schema Information
#
# Table name: verdict_scores
#
#  id                 :integer          not null, primary key
#  verdict_id         :integer
#  judge_id           :integer
#  verdict_rater_id   :integer
#  verdict_rater_type :string
#  quality_score      :integer
#  rating_score       :integer
#  data               :hstore
#  appeal_judge       :boolean
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class VerdictScore < ActiveRecord::Base
  validates :verdict_rater_type, presence: true
  validates :verdict_rater_id, presence: true
  validates :verdict_id, uniqueness: { scope: :verdict_rater_id }
  validates :judge_id, presence: true
  store_accessor :data, :tmp

  belongs_to :verdict
  belongs_to :judge
  belongs_to :verdict_rater, polymorphic: true
end
