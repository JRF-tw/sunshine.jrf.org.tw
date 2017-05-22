# == Schema Information
#
# Table name: careers
#
#  id                  :integer          not null, primary key
#  profile_id          :integer
#  career_type         :string
#  old_unit            :string
#  old_title           :string
#  old_assign_court    :string
#  old_assign_judicial :string
#  old_pt              :string
#  new_unit            :string
#  new_title           :string
#  new_assign_court    :string
#  new_assign_judicial :string
#  new_pt              :string
#  start_at            :date
#  end_at              :date
#  publish_at          :date
#  source              :text
#  source_link         :text
#  origin_desc         :text
#  memo                :text
#  created_at          :datetime
#  updated_at          :datetime
#  is_hidden           :boolean
#  owner_id            :integer
#  owner_type          :string
#

require 'rails_helper'

RSpec.describe Career, type: :model do
  let!(:career) { create :career }

  it 'FactoryGirl' do
    expect(career).not_to be_new_record
  end

  it 'has_many :careers, dependent: :destroy' do
    expect(Career.count).to eq(1)
    owner = career.owner
    owner.destroy
    expect(Career.count).to be_zero
  end
end
