# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string
#  title      :string
#  content    :text
#  comment    :text
#  no         :string
#  source     :text
#  file       :string
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review) { create :review }

  it 'FactoryGirl' do
    expect(review).not_to be_new_record
  end

  it 'has_many :careers, dependent: :destroy' do
    expect(Review.count).to eq(1)
    profile = review.profile
    profile.destroy
    expect(Review.count).to be_zero
  end
end
