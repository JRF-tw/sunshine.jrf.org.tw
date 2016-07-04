# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string(255)
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :string(255)
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Education, type: :model do
  let!(:education) { FactoryGirl.create :education }

  it "FactoryGirl" do
    expect(education).not_to be_new_record
  end

  it "has_many :educations, dependent: :destroy" do
    expect(Education.count).to eq(1)
    profile = education.profile
    profile.destroy
    expect(Education.count).to be_zero
  end
end
