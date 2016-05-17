class Scrap::NotifyDailyContext < BaseContext
  SCRAP_MODELS = { court: "法院", judge: "法官", verdict: "判決書", schedule: "庭期表" }

  after_perform :cleanup_redis_date

  def perform(scrap_models = SCRAP_MODELS)
    run_callbacks :perform do
      scrap_models.keys.map(&:to_s).each do |model|
        message = parse_message(model)
        SlackService.notify_scrap_daily(message) if message
      end
    end
  end

  private

  def parse_message(model)
    interval = Redis::Value.new("daily_scrap_#{model}_intervel").value
    count = Redis::Counter.new("daily_scrap_#{model}_count").value
    if interval && count > 0
      message = "\n#{ SCRAP_MODELS[model.to_sym] }爬蟲報告 :\n今日爬取時間參數 : #{ interval }\n今日爬取總數 : #{ count } 筆\n資料庫目前總數 : #{ eval("#{ model.camelize }.count") } 筆"
      return message
    else
      return nil
    end
  end

  def cleanup_redis_date
    SCRAP_MODELS.keys.map(&:to_s).each do |model|
      Redis::Value.new("daily_scrap_#{model}_intervel").delete
      Redis::Counter.new("daily_scrap_#{model}_count").value = 0
    end
  end
end
