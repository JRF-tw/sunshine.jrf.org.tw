# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_judgment      :boolean          default(FALSE)
#  adjudge_date     :date
#  publish_date     :date
#

FactoryGirl.define do
  factory :verdict do
    story { create(:story) }

    trait :with_file do
      file { File.open("#{Rails.root}/spec/fixtures/scrap_data/judgment.html") }
    end
  end

end
