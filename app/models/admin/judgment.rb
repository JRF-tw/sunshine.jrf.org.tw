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

class Admin::Judgment < ::Judgment
  belongs_to :court, class_name: 'Admin::Court'
  belongs_to :main_judge, class_name: 'Admin::Profile', foreign_key: :main_judge_id
  belongs_to :presiding_judge, class_name: 'Admin::Profile', foreign_key: :presiding_judge_id
  has_many :judgment_judges, dependent: :destroy
  has_many :judges, class_name: 'Admin::Profile', through: :judgment_judges
  has_many :judgment_prosecutors, dependent: :destroy
  has_many :prosecutors, class_name: 'Admin::Profile', through: :judgment_prosecutors

  validates :court_id, presence: true
  validates :judge_no, presence: { unless: :court_no? }

  JUDGMENT_TYPES = [
    '判決',
    '裁定'
  ].freeze

  def court_no?
    court_no.present?
  end
end
