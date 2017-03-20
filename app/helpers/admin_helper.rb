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

  def collect_for_judge_name
    Judge.all.map { |j| [j.name, j.id] }
  end

  def collect_for_score_type
    [['開庭評鑑', 'ScheduleScore'], ['判決評鑑', 'VerdictScore']]
  end

  # REFACTOR:
  def collect_all_roles
    [['律師', 'Lawyer', { 'data-role-names' => lawyer_names.to_json }], ['當事人', 'Party', { 'data-role-names' => party_names.to_json }], ['觀察者', 'CourtObserver', { 'data-role-names' => observer_names.to_json }]]
  end

  def collect_by_roles(role)
    return [] unless role
    case role
    when 'Party'
      party_names
    when 'Lawyer'
      lawyer_names
    when 'CourtObserver'
      observer_names
    end
  end

  def score_show_path(s)
    s.class.name == 'ScheduleScore' ? link_to('詳細資料', schedule_admin_score_path(s), class: 'btn btn-mini') : link_to('詳細資料', verdict_admin_score_path(s), class: 'btn btn-mini')
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

  def score_rater_link(score)
    score_type = score.class.name.underscore.split('_').first
    rater = score.send("#{score_type}_rater")
    show_role_link(rater)
  end

  def show_role_link(role)
    wording = role.model_name.human + ' - ' + role.name
    role_type = role.class.name.downcase.gsub('court', '')
    path = Rails.application.routes.url_helpers.send("admin_#{role_type}_path", role)
    link_to wording, path, target: '_blank'
  end

  private

  def party_names
    Party.all.map { |j| ["當事人 - #{j.name}", j.id] }
  end

  def lawyer_names
    Lawyer.all.map { |j| ["律師 - #{j.name}", j.id] }
  end

  def observer_names
    CourtObserver.all.map { |o| ["觀察者 - #{o.name}", o.id] }
  end
end
