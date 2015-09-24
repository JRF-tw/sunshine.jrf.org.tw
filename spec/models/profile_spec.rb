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

  context "search for profile" do
    it "suits" do
      #FactoryGirl.create :profile
      #suit = Suit.find_state(params_utf8[:state]).front_like_search({title: params_utf8[:q], summary: params_utf8[:q], content: params_utf8[:q], keyword: params_utf8[:q]}).page(params[:page]).per(12)
    end

    it "judges" do
      jp = FactoryGirl.create :judge_profile, name: "xxxzzz", current_court: "台北法官"
      people = Profile.judges.find_current_court("台北法官").front_like_search({ :name => "xz" })
      expect(people.first.name).to eq(jp.name)
    end

    it "prosecutors" do
      pp = FactoryGirl.create :prosecutor_profile, name: "yyyzzz", current_court: "台北檢查官"
      people = Profile.prosecutors.find_current_court("台北檢查官").front_like_search({ :name => "yy" })
      expect(people.first.name).to eq(pp.name)
    end
  end

end
