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
#  published_on     :date
#  content_file     :string
#  crawl_data       :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reason           :string
#  related_stories  :text
#  abs_url          :string
#

class Rule < ActiveRecord::Base
  mount_uploader :file, VerdictFileUploader
  mount_uploader :content_file, VerdictFileUploader
  serialize :party_names, Array
  serialize :lawyer_names, Array
  serialize :judges_names, Array
  serialize :prosecutor_names, Array
  serialize :related_stories, Array
  store_accessor :crawl_data, :judge_word, :roles_data
  belongs_to :story
end
