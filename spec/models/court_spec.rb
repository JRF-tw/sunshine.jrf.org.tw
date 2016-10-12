# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string
#  full_name  :string
#  name       :string
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean          default(TRUE)
#  code       :string
#  scrap_name :string
#

require "rails_helper"

RSpec.describe Court, type: :model do
  let!(:court) { create :court }

  it "FactoryGirl" do
    expect(court).not_to be_new_record
  end
end
