module ApplicationHelper

  def class_of_suits
    if (params[:controller] == "suits")
      return "active"
    else
      return nil
    end
  end

  def class_of_judges
    if (params[:controller] == "profiles") && (params[:action] == "judges")
      return "active"
    else
      return nil
    end
  end

  def class_of_prosecutors
    if (params[:controller] == "profiles") && (params[:action] == "prosecutors")
      return "active"
    else
      return nil
    end
  end

  def class_of_about
    if (params[:controller] == "base") && (params[:action] == "about")
      return "active"
    else
      return nil
    end
  end

  def class_of_searchs
    if (params[:controller] == "searchs")
      return "active"
    else
      return nil
    end
  end
end