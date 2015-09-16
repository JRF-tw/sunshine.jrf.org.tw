# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  current     :string(255)
#  avatar      :string(255)
#  gender      :string(255)
#  birth_year  :integer
#  stage       :integer
#  appointment :string(255)
#  memo        :text
#  source      :hstore
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let!(:profile){ FactoryGirl.create :profile }

  it "FactoryGirl" do
    expect(profile).not_to be_new_record
  end

  it "scope had_avatar" do
  	expect(Profile.had_avatar.count).to be_zero
  	FactoryGirl.create :profile_had_avatar
  	expect(Profile.had_avatar.count).to eq(1)
  end
end
