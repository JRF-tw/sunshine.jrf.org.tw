# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string
#  unit         :string
#  title        :string
#  publish_at   :date
#  source       :text
#  source_link  :text
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#  is_hidden    :boolean
#

require "rails_helper"

RSpec.describe License, type: :model do
  let!(:license) { create :license }

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
