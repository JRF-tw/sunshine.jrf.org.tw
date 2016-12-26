# == Schema Information
#
# Table name: prosecutors_offices
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  court_id   :integer
#  is_hidden  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ProsecutorsOffice, type: :model do
  let!(:prosecutors_office) { create :prosecutors_office }

  it 'FactoryGirl' do
    expect(prosecutors_office).not_to be_new_record
  end
end
