class Logs::AddCrawlerError
  class << self
    include Rails.application.routes.url_helpers

    def add_verdict_error(crawler_history, verdict, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_verdict), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      error_message = ["判決書 : #{admin_verdict_url(verdict, host: Setting.host)}, #{message}"]
      crawler_log.crawler_errors << error_message unless crawler_log.crawler_errors.include?(error_message)
      crawler_log.save
    end

    def add_schedule_error(crawler_history, schedule, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_schedule), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      error_message = ["庭期表 : #{admin_schedule_url(schedule, host: Setting.host)}, #{message}"]
      crawler_log.crawler_errors << error_message unless crawler_log.crawler_errors.include?(error_message)
      crawler_log.save
    end

    def parse_court_data_error(crawler_history, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_court), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      crawler_log.crawler_errors << message unless crawler_log.crawler_errors.include?(message)
      crawler_log.save
    end

    def parse_judge_data_error(crawler_history, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_judge), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      crawler_log.crawler_errors << message unless crawler_log.crawler_errors.include?(message)
      crawler_log.save
    end

    def parse_supreme_court_judge_data_error(crawler_history, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_supreme_court_judge), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      crawler_log.crawler_errors << message unless crawler_log.crawler_errors.include?(message)
      crawler_log.save
    end

    def parse_verdict_data_error(crawler_history, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_verdict), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      crawler_log.crawler_errors << message unless crawler_log.crawler_errors.include?(message)
      crawler_log.save
    end

    def parse_schedule_data_error(crawler_history, type, message)
      crawler_log = crawler_history.crawler_logs.find_or_create_by(crawler_kind: CrawlerKinds.list.keys.index(:crawler_schedule), crawler_error_type: CrawlerErrorTypes.list.keys.index(type))
      crawler_log.crawler_errors << message unless crawler_log.crawler_errors.include?(message)
      crawler_log.save
    end
  end
end
