# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string
#  title             :string
#  procedure_unit    :string
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :text
#  punish_link       :string
#  file              :string
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#  is_hidden         :boolean
#

require 'rails_helper'

RSpec.describe Procedure, type: :model do

  it 'has_many :procedures, dependent: :destroy' do
    procedure = create :procedure
    expect(Procedure.count).to eq(1)
    suit = procedure.suit
    suit.destroy
    expect(Procedure.count).to be_zero
  end

end
