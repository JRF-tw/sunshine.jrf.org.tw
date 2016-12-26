# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Bulletin, type: :model do
  let!(:bulletin) { create :bulletin }

  it 'FactoryGirl' do
    expect(bulletin).not_to be_new_record
  end
end
