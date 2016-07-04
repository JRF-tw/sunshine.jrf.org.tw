# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string(255)
#  full_name  :string(255)
#  name       :string(255)
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Court, type: :model do
  let!(:court) { FactoryGirl.create :court }

  it "FactoryGirl" do
    expect(court).not_to be_new_record
  end
end
