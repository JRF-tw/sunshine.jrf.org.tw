# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  is_judgment      :boolean          default(FALSE)
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  adjudge_date     :date
#  main_judge_id    :integer
#  main_judge_name  :string
#

class Verdict < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  serialize :defendant_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array
  has_many :lawyer_verdicts
  has_many :lawyers, through: :lawyer_verdicts
  has_many :judge_verdicts
  has_many :judges, through: :judge_verdicts
  has_many :defendant_verdicts
  has_many :defendants, through: :defendant_verdicts
  belongs_to :story
  belongs_to :main_judge, class_name: "Judge", foreign_key: :main_judge_id

  scope :newest, ->{ order("id DESC") }

  class << self
    def ransackable_scopes(auth_object = nil)
      [ :unexist_defendant_names, :unexist_lawyer_names, :unexist_judges_names, :unexist_prosecutor_names ]
    end

    def unexist_defendant_names
      where(defendant_names: nil)
    end

    def unexist_lawyer_names
      where(lawyer_names: nil)
    end

    def unexist_judges_names
      where(judges_names: nil)
    end

    def unexist_prosecutor_names
      where(prosecutor_names: nil)
    end
  end

end
