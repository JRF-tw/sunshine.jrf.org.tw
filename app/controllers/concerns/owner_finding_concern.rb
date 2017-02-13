module OwnerFindingConcern

  private

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
