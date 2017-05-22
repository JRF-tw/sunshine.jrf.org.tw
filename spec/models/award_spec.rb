# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  award_type  :string
#  unit        :string
#  content     :text
#  publish_at  :date
#  source      :text
#  source_link :text
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#  is_hidden   :boolean
#

require 'rails_helper'

RSpec.describe Award, type: :model do
  let!(:award) { create :award }

  it 'FactoryGirl' do
    expect(award).not_to be_new_record
  end

  it 'has_many :awards, dependent: :destroy' do
    expect(Award.count).to eq(1)
    owner = award.owner
    owner.destroy
    expect(Award.count).to be_zero
  end
end
