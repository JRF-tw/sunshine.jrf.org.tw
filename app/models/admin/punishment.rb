# == Schema Information
#
# Table name: punishments
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  decision_unit    :string(255)
#  unit             :string(255)
#  title            :string(255)
#  claimant         :string(255)
#  no               :string(255)
#  decision_no      :string(255)
#  punish_type      :string(255)
#  relevant_date    :date
#  decision_result  :text
#  decision_source  :string(255)
#  reason           :text
#  is_anonymous     :boolean
#  anonymous_source :string(255)
#  anonymous        :string(255)
#  origin_desc      :text
#  proposer         :string(255)
#  plaintiff        :string(255)
#  defendant        :string(255)
#  reply            :text
#  reply_source     :string(255)
#  punish           :string(255)
#  content          :text
#  summary          :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Admin::Punishment < ::Punishment
  belongs_to :profile, :class_name => "Admin::Profile"

  validates_presence_of :profile_id
end
