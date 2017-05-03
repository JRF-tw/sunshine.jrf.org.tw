# == Schema Information
#
# Table name: rules
#
#  id                  :integer          not null, primary key
#  story_id            :integer
#  file                :string
#  party_names         :text
#  lawyer_names        :text
#  judges_names        :text
#  prosecutor_names    :text
#  published_on        :date
#  content_file        :string
#  crawl_data          :hstore
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  reason              :string
#  related_stories     :text
#  original_url        :string
#  adjudged_on         :date
#  stories_history_url :string
#

FactoryGirl.define do
  factory :rule do
    story { create(:story) }
  end

end
