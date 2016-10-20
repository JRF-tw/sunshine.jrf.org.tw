# == Schema Information
#
# Table name: crawler_logs
#
#  id                 :integer          not null, primary key
#  crawler_history_id :integer
#  crawler_kind       :integer
#  crawler_error_type :integer
#  crawler_errors     :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class CrawlerLog < ActiveRecord::Base
  validates :crawler_history_id, presence: true
  validates :crawler_kind, presence: true
  validates :crawler_error_type, presence: true
  belongs_to :crawler_history

  enum crawler_kind: CrawlerKinds.list.keys
  enum crawler_error_type: CrawlerErrorTypes.list.keys
  serialize :crawler_errors, Array
end
