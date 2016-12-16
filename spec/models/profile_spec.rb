# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string
#  current            :string
#  avatar             :string
#  gender             :string
#  gender_source      :text
#  birth_year         :integer
#  birth_year_source  :text
#  stage              :integer
#  stage_source       :text
#  appointment        :string
#  appointment_source :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  current_court      :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  current_department :string
#  current_branch     :string
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let!(:profile) { create :profile }

  it 'FactoryGirl' do
    expect(profile).not_to be_new_record
  end

  it 'scope had_avatar' do
    expect(Profile.had_avatar.count).to be_zero
    create :profile_had_avatar
    expect(Profile.had_avatar.count).to eq(1)
  end

  context 'search for profile' do
    it 'judges' do
      Profile.destroy_all
      create :court, full_name: '台北法官', name: '台北法官'
      create :court, full_name: '台南法官', name: '台南法官'
      create :judge_profile, name: 'sdgfsdg', current_court: '台北法官'
      create :judge_profile, name: 'xzxzxz', current_court: '台南法官'
      jp1 = create :judge_profile, name: 'xxxzzz', current_court: '台北法官'

      people = Profile.judges.find_current_court('台北法官').front_like_search(name: 'xz')
      expect(people.count).to eq(1)
      expect(people.first.name).to eq(jp1.name)

      people = Profile.judges.find_current_court('請選擇').front_like_search(name: 'xz')
      expect(people.count).to eq(2)

      people = Profile.judges.find_current_court('請選擇').front_like_search(name: '')
      expect(people.count).to eq(3)
    end

    it 'prosecutors' do
      Profile.destroy_all
      create :prosecutors_office, full_name: '台北檢察署', name: '台北檢察署'
      create :prosecutors_office, full_name: '台南檢察署', name: '台南檢察署'
      pp1 = create :prosecutor_profile, name: 'yyyzzz', current_court: '台北檢察署'
      create :prosecutor_profile, name: 'sfdsdf', current_court: '台北檢察署'
      create :prosecutor_profile, name: 'zyyzzyz', current_court: '台南檢察署'

      people = Profile.prosecutors.find_current_court('台北檢察署').front_like_search(name: 'yy')
      expect(people.count).to eq(1)
      expect(people.first.name).to eq(pp1.name)

      people = Profile.prosecutors.find_current_court('請選擇').front_like_search(name: 'yy')
      expect(people.count).to eq(2)

      people = Profile.prosecutors.find_current_court('請選擇').front_like_search(name: '')
      expect(people.count).to eq(3)
    end

  end
end
