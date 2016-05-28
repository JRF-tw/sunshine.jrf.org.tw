# == Schema Information
#
# Table name: judgments
#
#  id                 :integer          not null, primary key
#  court_id           :integer
#  main_judge_id      :integer
#  presiding_judge_id :integer
#  judge_no           :string
#  court_no           :string
#  judge_type         :string
#  judge_date         :date
#  reason             :text
#  content            :text
#  comment            :text
#  source             :text
#  source_link        :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  is_hidden          :boolean
#

FactoryGirl.define do
  factory :judgment do
    court do
      FactoryGirl.create :court
    end
    judge_no "abc123"
  end

end
