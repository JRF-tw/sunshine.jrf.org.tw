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

class Judgment < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :judge_date

  belongs_to :court
  belongs_to :main_judge, class_name: "Profile", foreign_key: :main_judge_id
  belongs_to :presiding_judge, class_name: "Profile", foreign_key: :presiding_judge_id
  has_many :judgment_judges, dependent: :destroy
  has_many :judges, through: :judgment_judges
  has_many :judgment_prosecutors, dependent: :destroy
  has_many :prosecutors, through: :judgment_prosecutors

  scope :newest, ->{ order("id DESC") }
end
