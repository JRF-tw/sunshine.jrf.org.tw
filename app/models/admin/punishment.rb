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
#

class Admin::Punishment < ::Punishment
  
  belongs_to :profile, class_name: "Admin::Profile", counter_cache: :punishments_count

  validates_presence_of :profile_id
end
