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
  KINDS = { crawler_court: "法院錯誤", crawler_judge: "法官錯誤", crawler_branch: "股別錯誤", crawler_schedule: "庭期錯誤", crawler_verdict: "判決書錯誤" }
  ERROR_TYPES = { parse_date_failed: "解析回傳資料失敗", date_not_in_db: "爬蟲取得資料不存在於資料庫" }

  enum crawler_kind: KINDS.keys
  enum crawler_error_type: ERROR_TYPES.keys
  serialize :crawler_errors, Array
end
