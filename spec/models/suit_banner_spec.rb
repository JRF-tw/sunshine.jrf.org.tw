# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  url        :string
#  alt_string :string
#  title      :string
#  content    :text
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe SuitBanner, type: :model do
  let!(:suit_banner) { create :suit_banner }

  it "FactoryGirl" do
    expect(suit_banner).not_to be_new_record
  end
end
