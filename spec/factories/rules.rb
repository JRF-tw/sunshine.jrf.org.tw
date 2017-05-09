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
    trait :with_file do
      file { File.open("#{Rails.root}/spec/fixtures/scrap_data/rule.html") }
    end

    trait :with_original_url do
      original_url 'http://jirs.judicial.gov.tw/FJUD/index_1_S.aspx?p=cuFaWjq4uRFo8IK6d3HqDRI%2fH02WUkgUP9selP3kGCE%3d'
    end
  end

end
