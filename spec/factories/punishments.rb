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
#  punish_no        :string(255)
#  decision_no      :string(255)
#  punish_type      :string(255)
#  relevant_date    :date
#  decision_result  :text
#  decision_source  :text
#  reason           :text
#  is_anonymous     :boolean
#  anonymous_source :text
#  anonymous        :string(255)
#  origin_desc      :text
#  proposer         :string(255)
#  plaintiff        :string(255)
#  defendant        :string(255)
#  reply            :text
#  reply_source     :text
#  punish           :text
#  content          :text
#  summary          :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#  is_hidden        :boolean
#

FactoryGirl.define do
  factory :punishment do
    profile do
      FactoryGirl.create :profile
    end
    decision_unit 'foo'
  end

end
