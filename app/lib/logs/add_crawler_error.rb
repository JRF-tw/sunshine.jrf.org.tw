class Logs::AddCrawlerError
  class << self
    include Rails.application.routes.url_helpers

    def add_verdict_error(crawler_history, verdict, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_verdict), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      error_message = ["判決書 : #{admin_verdict_url(verdict, host: Setting.host)}, #{message}"]
      crawler_log.crawler_errors << error_message unless crawler_log.crawler_errors.include?(error_message)
      crawler_log.save
    end
  end
end
