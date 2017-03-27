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
#  adjudge_date     :date
#  published_on     :date
#  content_file     :string
#  crawl_data       :hstore
#  roles_data       :hstore
#  reason           :string
#  related_stories  :text
#

class Verdict < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  mount_uploader :content_file, VerdictFileUploader
  serialize :party_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array
  serialize :related_stories, Array
  store_accessor :crawl_data, :judge_word, :roles_data
  has_many :verdict_relations, dependent: :destroy
  has_many :parties, through: :verdict_relations, source: :person, source_type: 'Party'
  has_many :lawyers, through: :verdict_relations, source: :person, source_type: 'Lawyer'
  has_many :judges, through: :verdict_relations, source: :person, source_type: 'Judge'
  belongs_to :story

  scope :newest, -> { order('id DESC') }

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:unexist_party_names, :unexist_lawyer_names, :unexist_judges_names, :unexist_prosecutor_names]
    end

    def unexist_party_names
      where(party_names: nil)
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
