# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string(255)
#  pic_m      :string(255)
#  pic_s      :string(255)
#  url        :string(255)
#  alt_string :string(255)
#  title      :string(255)
#  content    :string(255)
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
