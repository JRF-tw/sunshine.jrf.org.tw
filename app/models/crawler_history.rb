# == Schema Information
#
# Table name: crawler_histories
#
#  id              :integer          not null, primary key
#  crawler_on      :date
#  courts_count    :integer          default(0), not null
#  branches_count  :integer          default(0), not null
#  judges_count    :integer          default(0), not null
#  verdicts_count  :integer          default(0), not null
#  schedules_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CrawlerHistory < ActiveRecord::Base
  validates :crawler_on, presence: true, uniqueness: true
  has_many :crawler_logs, dependent: :destroy

  scope :has_verdicts, -> { where('verdicts_count > ? ', 0) }
  scope :newest, -> { order('crawler_on DESC') }
  scope :oldest, -> { order('crawler_on ASC') }

  def success_count(crawler_kind, crawler_error_type)
    verdicts_count - error_log_count(crawler_kind, crawler_error_type)
  end

  def failed_count(crawler_kind, crawler_error_type)
    error_log_count(crawler_kind, crawler_error_type)
  end

  def find_log(crawler_kind, crawler_error_type)
    crawler_logs.find_by(crawler_kind: CrawlerKinds.list.keys.index(crawler_kind), crawler_error_type: CrawlerErrorTypes.list.keys.index(crawler_error_type))
  end

  def error_log_count(kind, error_type)
    return 0 unless log = find_log(kind, error_type)
    log.crawler_errors.count
  end
end
