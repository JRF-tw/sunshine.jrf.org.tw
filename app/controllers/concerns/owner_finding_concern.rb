module OwnerFindingConcern

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/admin\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def owner_type
    case @owner.class.name.demodulize
    when 'Judge'
      '法官'
    when 'Prosecutor'
      '檢察官'
    end
  end

  def owner_id
    params["#{@owner_class.to_s.downcase.demodulize}_id"]
  end

  def owner_pluralize
    @owner_pluralize = @owner.class.to_s.downcase.demodulize.pluralize
  end

  def owner_singularize
    @owner_singularize = @owner.class.to_s.downcase.demodulize.singularize
  end
end
