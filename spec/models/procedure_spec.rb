# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string(255)
#  title             :string(255)
#  procedure_unit    :string(255)
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string(255)
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :string(255)
#  punish_link       :string(255)
#  file              :string(255)
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe Procedure, type: :model do
  
  it "has_many :procedures, dependent: :destroy" do
    procedure = FactoryGirl.create :procedure
    expect(Procedure.count).to eq(1)
    suit = procedure.suit
    suit.destroy
    expect(Procedure.count).to be_zero
  end

end
