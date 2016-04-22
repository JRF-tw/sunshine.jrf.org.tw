# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_judgment      :boolean
#

FactoryGirl.define do
  factory :verdict do
    content "無罪釋放"
    story { FactoryGirl.create(:story) }
  end

end
