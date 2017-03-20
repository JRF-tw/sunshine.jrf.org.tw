module Api::PaginationConcern
  def paginate(scope, default_per_page = 5)
    collection = scope.page(params[:page]).per(default_per_page.to_i)

    current = collection.current_page
    total = collection.num_pages
    per_page = collection.limit_value
    [{
      current:  current,
      previous: collection.prev_page,
      next:     collection.next_page,
      per_page: per_page,
      pages:    total,
      count:    collection.total_count
    }, collection]
  end
end
