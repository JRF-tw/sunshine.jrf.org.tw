# == Schema Information
#
# Table name: careers
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  career_type        :string(255)
#  older       :hstore
#  newer       :hstore
#  start_at    :date
#  end_at      :date
#  publish_at  :date
#  source      :text
#  source_link :string(255)
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Career, type: :model do
  let!(:career){ FactoryGirl.create :career }

  it "FactoryGirl" do
    expect(career).not_to be_new_record
  end

  it "has_many :careers, :dependent => :destroy" do
    expect(Career.count).to eq(1)
    profile = career.profile
    profile.destroy
    expect(Career.count).to be_zero
  end
end