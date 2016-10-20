class Logs::AddCrawlerError
  class << self
    include Rails.application.routes.url_helpers

    def add_verdict_error(crawler_history, verdict, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: :crawler_verdict, crawler_error_type: type)
      crawler_log.crawler_errors << ["判決書 : #{admin_verdict_url(verdict.id, host: Setting.host)}, #{message}"]
      crawler_log.save
    end
  end
end
