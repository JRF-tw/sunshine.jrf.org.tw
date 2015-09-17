# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  award_type  :string(255)
#  unit        :string(255)
#  content     :text
#  publish_at  :date
#  source      :text
#  source_link :string(255)
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Award, type: :model do
  let!(:award){ FactoryGirl.create :award }

  it "FactoryGirl" do
    expect(award).not_to be_new_record
  end

  it "has_many :awards, dependent: :destroy" do
    expect(Award.count).to eq(1)
    profile = award.profile
    profile.destroy
    expect(Award.count).to be_zero
  end
end
