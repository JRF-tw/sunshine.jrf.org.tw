# == Schema Information
#
# Table name: banners
#
#  id          :integer          not null, primary key
#  weight      :integer
#  is_hidden   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string
#  link        :string
#  btn_wording :string
#  pic         :string
#  desc        :string
#

require 'rails_helper'

RSpec.describe Banner, type: :model do
  let!(:banner) { create :banner }

  it 'FactoryGirl' do
    expect(banner).not_to be_new_record
  end

  context 'scope' do
    context 'order_by_weight' do
      let!(:banners) { create_list :banner, 3, weight: 3 }
      it { expect(Banner.order_by_weight.last).to eq(banner) }
    end
  end
end
