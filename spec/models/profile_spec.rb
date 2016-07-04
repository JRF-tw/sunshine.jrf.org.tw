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

require "rails_helper"

RSpec.describe Profile, type: :model do
  let!(:profile) { FactoryGirl.create :profile }

  it "FactoryGirl" do
    expect(profile).not_to be_new_record
  end

  it "scope had_avatar" do
    expect(Profile.had_avatar.count).to be_zero
    FactoryGirl.create :profile_had_avatar
    expect(Profile.had_avatar.count).to eq(1)
  end

  context "search for profile" do
    it "judges" do
      Profile.destroy_all
      FactoryGirl.create :court, court_type: "法院", full_name: "台北法官", name: "台北法官"
      FactoryGirl.create :court, court_type: "法院", full_name: "台南法官", name: "台南法官"
      FactoryGirl.create :judge_profile, name: "sdgfsdg", current_court: "台北法官"
      FactoryGirl.create :judge_profile, name: "xzxzxz", current_court: "台南法官"
      jp1 = FactoryGirl.create :judge_profile, name: "xxxzzz", current_court: "台北法官"

      people = Profile.judges.find_current_court("台北法官").front_like_search(name: "xz")
      expect(people.count).to eq(1)
      expect(people.first.name).to eq(jp1.name)

      people = Profile.judges.find_current_court("請選擇").front_like_search(name: "xz")
      expect(people.count).to eq(2)

      people = Profile.judges.find_current_court("請選擇").front_like_search(name: "")
      expect(people.count).to eq(3)
    end

    it "prosecutors" do
      Profile.destroy_all
      FactoryGirl.create :court, court_type: "檢察署", full_name: "台北檢察署", name: "台北檢察署"
      FactoryGirl.create :court, court_type: "檢察署", full_name: "台南檢察署", name: "台南檢察署"
      pp1 = FactoryGirl.create :prosecutor_profile, name: "yyyzzz", current_court: "台北檢察署"
      FactoryGirl.create :prosecutor_profile, name: "sfdsdf", current_court: "台北檢察署"
      FactoryGirl.create :prosecutor_profile, name: "zyyzzyz", current_court: "台南檢察署"

      people = Profile.prosecutors.find_current_court("台北檢察署").front_like_search(name: "yy")
      expect(people.count).to eq(1)
      expect(people.first.name).to eq(pp1.name)

      people = Profile.prosecutors.find_current_court("請選擇").front_like_search(name: "yy")
      expect(people.count).to eq(2)

      people = Profile.prosecutors.find_current_court("請選擇").front_like_search(name: "")
      expect(people.count).to eq(3)
    end

  end
end
