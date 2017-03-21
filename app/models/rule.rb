# == Schema Information
#
# Table name: rules
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  publish_on       :date
#  content_file     :string
#  crawl_data       :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  summary          :string
#

class Rule < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  mount_uploader :content_file, VerdictFileUploader
  serialize :party_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array
  store_accessor :crawl_data, :date, :judge_word, :related_story, :roles_data
  belongs_to :story
end