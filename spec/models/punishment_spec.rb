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
#

require "rails_helper"

RSpec.describe Punishment, type: :model do
  let!(:punishment) { FactoryGirl.create :punishment }

  it "FactoryGirl" do
    expect(punishment).not_to be_new_record
  end

  it "has_many :punishment, dependent: :destroy" do
    expect(Punishment.count).to eq(1)
    profile = punishment.profile
    profile.destroy
    expect(Punishment.count).to be_zero
  end

  it "#punishments_count counter cache" do
    profile = FactoryGirl.create :profile
    Admin::Punishment.create decision_unit: "foofoo", profile_id: profile.id
    profile.reload
    expect(profile.punishments_count).to eq(1)
    Admin::Punishment.last.destroy
    profile.reload
    expect(profile.punishments_count).to be_zero
  end
end
