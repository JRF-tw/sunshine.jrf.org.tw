# == Schema Information
#
# Table name: punishments
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  decision_unit    :string
#  unit             :string
#  title            :string
#  claimant         :string
#  punish_no        :string
#  decision_no      :string
#  punish_type      :string
#  relevant_date    :date
#  decision_result  :text
#  decision_source  :text
#  reason           :text
#  is_anonymous     :boolean
#  anonymous_source :text
#  anonymous        :string
#  origin_desc      :text
#  proposer         :string
#  plaintiff        :string
#  defendant        :string
#  reply            :text
#  reply_source     :text
#  punish           :text
#  content          :text
#  summary          :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#  is_hidden        :boolean
#  status           :text
#  owner_id         :integer
#  owner_type       :string
#

class Punishment < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :relevant_date

  belongs_to :owner, polymorphic: true
  belongs_to :profile

  scope :newest, -> { order('id DESC') }
  scope :order_by_relevant_date, -> { order('relevant_date DESC, id DESC') }
  scope :had_reason, -> { where.not(reason: nil) }

end
