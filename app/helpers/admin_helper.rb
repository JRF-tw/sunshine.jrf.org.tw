module AdminHelper
  def admin_widget_box(title, icon: nil, &block)
    render partial: "admin/base/widget_box", locals: { main: capture(&block), title: title, icon: icon }
  end

  def sort_buttons(court, page = nil)
    url_array = []
    { first: "頂", up: "上", down: "下", last: "底" }.each do |weight, label|
      url_array << link_to(label, admin_court_update_weight_path(court, admin_court: { weight: weight }, page: page, format: :js), class: "btn btn-mini btn-info", remote: true, method: :put)
    end
    safe_join(url_array, " ")
  end

  def collection_for_crawler_kinds
    CrawlerLog::KINDS.to_enum.with_index.map{ |n, i| [n.last, i] }
  end

  def collection_for_crawler_error_types
    CrawlerLog::ERROR_TYPES.to_enum.with_index.map{ |n, i| [n.last, i] }
  end
end
