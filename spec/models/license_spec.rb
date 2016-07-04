# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string(255)
#  unit         :string(255)
#  title        :string(255)
#  publish_at   :date
#  source       :text
#  source_link  :string(255)
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#

require "rails_helper"

RSpec.describe License, type: :model do
  let!(:license) { FactoryGirl.create :license }

  it "FactoryGirl" do
    expect(license).not_to be_new_record
  end

  it "has_many :licenses, dependent: :destroy" do
    expect(License.count).to eq(1)
    profile = license.profile
    profile.destroy
    expect(License.count).to be_zero
  end
end
