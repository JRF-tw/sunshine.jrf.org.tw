# == Schema Information
#
# Table name: suit_prosecutors
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe SuitProsecutor, type: :model do

  it "has_many :suit_prosecutors, dependent: :destroy" do
    suit_prosecutor = create :suit_prosecutor
    expect(SuitProsecutor.count).to eq(1)
    prosecutor = suit_prosecutor.prosecutor
    prosecutor.destroy
    expect(SuitProsecutor.count).to be_zero
  end
end
