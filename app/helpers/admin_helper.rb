module AdminHelper
  def admin_widget_box(title, icon: nil, &block)
    render partial: 'admin/base/widget_box', locals: { main: capture(&block), title: title, icon: icon }
  end

  def sort_buttons(court)
    url_array = []
    { first: '頂', up: '上', down: '下', last: '底' }.each do |weight, label|
      url_array << link_to(label, admin_court_update_weight_path(court, admin_court: { weight: weight }, format: :js), class: 'btn btn-mini btn-info', remote: true, method: :put)
    end
    safe_join(url_array, ' ')
  end

  def collection_for_crawler_kinds
    CrawlerKinds.list.to_enum.with_index.map { |n, i| [n.last, i] }
  end

  def collection_for_crawler_error_types
    CrawlerErrorTypes.list.to_enum.with_index.map { |n, i| [n.last, i] }
  end

  def success_scrap_verdict_judge_precentage(ch)
    calculate_failed = ch.crawler_logs.crawler_verdict.parse_judge_empty.last ? ch.crawler_logs.crawler_verdict.parse_judge_empty.last.crawler_errors.count.to_f / ch.verdicts_count.to_f : 0
    success_precentage(calculate_failed)
  end

  def success_scrap_verdict_lawyer_precentage(ch)
    calculate_failed = ch.crawler_logs.crawler_verdict.parse_lawyer_empty.last ? ch.crawler_logs.crawler_verdict.parse_lawyer_empty.last.crawler_errors.count.to_f / ch.verdicts_count.to_f : 0
    success_precentage(calculate_failed)
  end

  def success_scrap_verdict_party_precentage(ch)
    calculate_failed = ch.crawler_logs.crawler_verdict.parse_party_empty.last ? ch.crawler_logs.crawler_verdict.parse_party_empty.last.crawler_errors.count.to_f / ch.verdicts_count.to_f : 0
    success_precentage(calculate_failed)
  end

  def success_scrap_verdict_prosecutor_precentage(ch)
    calculate_failed = ch.crawler_logs.crawler_verdict.parse_prosecutor_empty.last ? ch.crawler_logs.crawler_verdict.parse_prosecutor_empty.last.crawler_errors.count.to_f / ch.verdicts_count.to_f : 0
    success_precentage(calculate_failed)
  end

  def success_precentage(calculate_failed)
    number_to_percentage((1 - calculate_failed) * 100, precision: 2)
  end
end
