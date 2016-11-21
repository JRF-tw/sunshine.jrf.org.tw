# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_hidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :bulletin do
    
  end

end
