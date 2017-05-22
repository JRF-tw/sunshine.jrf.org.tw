module OwnerFindingConcern

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/(\/admin)?\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def owner_type
    @owner.model_name.human
  end

  def owner_id
    params["#{@owner_class.to_s.downcase.demodulize}_id"]
  end
end
