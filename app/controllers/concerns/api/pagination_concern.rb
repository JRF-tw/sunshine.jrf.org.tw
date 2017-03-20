module Api::PaginationConcern
  include ActionView::Helpers::UrlHelper
  def paginate(scope, path_name, default_per_page = 20)
    collection = scope.page(params[:page]).per(default_per_page.to_i)
    current = collection.current_page
    total = collection.num_pages
    per_page = collection.limit_value
    [{
      current:  current,
      previous_url: prev_page_url(collection, path_name),
      next_url:     next_page_url(collection, path_name),
      per_page: per_page,
      pages:    total,
      count:    collection.total_count
    }, collection]
  end

  private

  def prev_page_url(collection, path_name)
    return nil unless collection.prev_page
    params[:page] = collection.prev_page
    send(path_name, params.slice(:q, :page))
  end

  def next_page_url(collection, path_name)
    return nil unless collection.next_page
    params[:page] = collection.next_page
    send(path_name, params.slice(:q, :page))
  end
end
