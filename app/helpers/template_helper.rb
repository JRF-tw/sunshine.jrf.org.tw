module TemplateHelper
  def calendar(year, date)
    content_tag :time, class: "cal" do
      concat content_tag :div, year.to_s, class: "cal__year"
      concat content_tag :div, date.to_s, class: "cal__date"
    end
  end

  def kv_cell(key, value)
    concat content_tag :dt, key.to_s, class: "term"
    content_tag :dd, value.to_s, class: "desc"
  end

  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "##{icon}"
    end
  end  
end
