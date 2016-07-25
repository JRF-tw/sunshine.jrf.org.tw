# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string
#  title             :string
#  procedure_unit    :string
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :text
#  punish_link       :string
#  file              :string
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#  is_hidden         :boolean
#

FactoryGirl.define do
  factory :procedure do
    profile do
      create :profile
    end
    suit do
      create :suit
    end
    unit "foo"
    title "bar"
    procedure_unit "haha"
    procedure_content "hoho"
    procedure_date Time.zone.today
  end

end
