class Scrap::NotifyAbnormalDataContext < BaseContext
  PARSE_SUCCESS_VALIDITY = 90
  before_perform :check_crawler_execute
  before_perform :check_parse_verdict_validity

  def initialize(crawler_history)
    @crawler_history = crawler_history
    @messages = []
  end

  def perform
    run_callbacks :perform do
      @messages.each do |m|
        SlackService.notify_scrap_daily_alert(m)
      end
    end
  end

  def check_crawler_execute
    get_courts_failed
    get_judges_failed
    get_verdicts_failed
    get_rules_failed
    get_schedules_failed
  end

  def check_parse_verdict_validity
    jugde_below_expectations
    lawyer_below_expectations
    party_below_expectations
    prosecutor_below_expectations
  end

  private

  def get_courts_failed
    if @crawler_history.crawler_on.monday? && @crawler_history.courts_count.zero?
      @messages << "日期 : #{@crawler_history.crawler_on}, 尚未爬取到任何 `法院`"
    end
  end

  def get_judges_failed
    if @crawler_history.judges_count.zero?
      @messages << "日期 : #{@crawler_history.crawler_on}, 尚未爬取到任何 `法官`"
    end
  end

  def get_verdicts_failed
    if @crawler_history.verdicts_count.zero?
      @messages << "日期 : #{@crawler_history.crawler_on}, 尚未爬取到任何 `判決書`"
    end
  end

  def get_rules_failed
    if @crawler_history.rules_count.zero?
      @messages << "日期 : #{@crawler_history.crawler_on}, 尚未爬取到任何 `裁決書`"
    end
  end

  def get_schedules_failed
    if @crawler_history.schedules_count.zero?
      @messages << "日期 : #{@crawler_history.crawler_on}, 尚未爬取到任何 `庭期`"
    end
  end

  def jugde_below_expectations
    precentage = (@crawler_history.success_count(:crawler_verdict, :parse_judge_error).to_f / @crawler_history.verdicts_count.to_f * 100).round(2)
    if precentage < PARSE_SUCCESS_VALIDITY
      @messages << "日期 : #{@crawler_history.crawler_on}, `法官`抓取效度未達期望標準, 效度為: #{precentage} %"
    end
  end

  def lawyer_below_expectations
    precentage = (@crawler_history.success_count(:crawler_verdict, :parse_lawyer_error).to_f / @crawler_history.verdicts_count.to_f * 100).round(2)
    if precentage < PARSE_SUCCESS_VALIDITY
      @messages << "日期 : #{@crawler_history.crawler_on}, `律師`抓取效度未達期望標準, 效度為: #{precentage} %"
    end
  end

  def party_below_expectations
    precentage = (@crawler_history.success_count(:crawler_verdict, :parse_party_error).to_f / @crawler_history.verdicts_count.to_f * 100).round(2)
    if precentage < PARSE_SUCCESS_VALIDITY
      @messages << "日期 : #{@crawler_history.crawler_on}, `當事人` 抓取效度未達期望標準, 效度為: #{precentage} %"
    end
  end

  def prosecutor_below_expectations
    precentage = (@crawler_history.success_count(:crawler_verdict, :parse_prosecutor_error).to_f / @crawler_history.verdicts_count.to_f * 100).round(2)
    if precentage < PARSE_SUCCESS_VALIDITY
      @messages << "日期 : #{@crawler_history.crawler_on}, `檢察官` 抓取效度未達期望標準, 效度為: #{precentage} %"
    end
  end
end
