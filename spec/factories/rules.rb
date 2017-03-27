# == Schema Information
#
# Table name: rules
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  publish_on       :date
#  content_file     :string
#  crawl_data       :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :rule do
    story { create(:story) }
  end

end
