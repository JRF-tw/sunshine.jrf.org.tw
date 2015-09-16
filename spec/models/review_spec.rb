# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  comment    :text
#  no         :string(255)
#  source     :string(255)
#  file       :string(255)
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review){ FactoryGirl.create :review }

  it "FactoryGirl" do
    expect(review).not_to be_new_record
  end

  it "has_many :careers, dependent: :destroy" do
    expect(Review.count).to eq(1)
    profile = review.profile
    profile.destroy
    expect(Review.count).to be_zero
  end
end
