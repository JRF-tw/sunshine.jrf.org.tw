# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :text
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#  owner_id   :integer
#  owner_type :string
#

require 'rails_helper'

RSpec.describe Education, type: :model do
  let!(:education) { create :education }

  it 'FactoryGirl' do
    expect(education).not_to be_new_record
  end

  it 'has_many :educations, dependent: :destroy' do
    expect(Education.count).to eq(1)
    owner = education.owner
    owner.destroy
    expect(Education.count).to be_zero
  end
end
