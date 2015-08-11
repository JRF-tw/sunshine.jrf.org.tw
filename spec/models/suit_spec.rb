# == Schema Information
#
# Table name: suits
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  summary    :text
#  content    :text
#  state      :string(255)
#  pic        :string(255)
#  suit_no    :integer
#  keyword    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Suit, type: :model do
  let!(:suit){ FactoryGirl.create :suit }

  it "FactoryGirl" do
    expect(suit).not_to be_new_record
  end
end
