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

  def collect_for_score_roles
    [['律師', 'Lawyer'], ['當事人', 'Party'], ['觀察者', 'CourtObserver']]
  end

  def precentage(numerator, denominator)
    number_to_percentage(numerator.to_f / denominator.to_f * 100, precision: 2)
  end

  def generate_crawler_hitory_pie_hash(key, crawler_history)
    @hash = {}
    crawler_history.crawler_logs.public_send(key.to_s).map(&:crawler_error_type).each do |cet|
      @hash.merge! CrawlerErrorTypes.list[cet.to_sym] => crawler_history.failed_count(key, cet.to_sym)
    end
    @hash.present? ? @hash : nil
  end

  def generate_crawler_daily_line_chart(crawler_histories)
    [
      { name: '法院總數', data: crawler_histories.inject({}) { |a, e| a.merge(e.crawler_on => e.courts_count) } },
      { name: '股別總數', data: crawler_histories.inject({}) { |a, e| a.merge(e.crawler_on => e.branches_count) } },
      { name: '法官總數', data: crawler_histories.inject({}) { |a, e| a.merge(e.crawler_on => e.judges_count) } },
      { name: '判決書總數', data: crawler_histories.inject({}) { |a, e| a.merge(e.crawler_on => e.verdicts_count) } },
      { name: '庭期總數', data: crawler_histories.inject({}) { |a, e| a.merge(e.crawler_on => e.schedules_count) } }
    ]
  end
end
