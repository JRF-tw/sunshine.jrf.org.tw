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

    trait :create_relation_by_role_name do
      after(:create) do |v|
        v.party_names.each do |name|
          party = Party.find_by_name(name)
          create :verdict_relation, person: party, verdict: v
        end

        v.lawyer_names.each do |name|
          lawyer = Lawyer.find_by_name(name)
          create :verdict_relation, person: lawyer, verdict: v
        end

        v.judges_names.each do |name|
          judge = Judge.find_by_name(name)
          create :verdict_relation, person: judge, verdict: v
        end
      end
    end

  end

end
