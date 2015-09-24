# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  pic_l      :string(255)
#  pic_m      :string(255)
#  pic_s      :string(255)
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Banner, type: :model do
  let!(:banner){ FactoryGirl.create :banner }

  it "FactoryGirl" do
    expect(banner).not_to be_new_record
  end
end
