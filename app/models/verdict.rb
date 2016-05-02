# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  is_judgment      :boolean
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  adjudge_date     :date
#

class Verdict < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  serialize :defendant_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array
  belongs_to :story

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
