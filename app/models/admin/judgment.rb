# == Schema Information
#
# Table name: judgments
#
#  id                 :integer          not null, primary key
#  court_id           :integer
#  main_judge_id      :integer
#  presiding_judge_id :integer
#  judge_no           :string(255)
#  court_no           :string(255)
#  judge_type         :string(255)
#  judge_date         :date
#  reason             :text
#  content            :text
#  comment            :text
#  source             :string(255)
#  source_link        :string(255)
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#

class Admin::Judgment < ::Judgment
  validates_presence_of :court_id
  validates_presence_of :judge_no, unless: :court_no?
  
  JUDGMENT_TYPES = [
    "判決",
    "裁定"
  ]

  def court_no?
    court_no.present?
  end 
end