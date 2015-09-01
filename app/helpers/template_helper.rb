module TemplateHelper
  def calendar(year, date)
    content_tag :time, class: 'cal' do
      concat content_tag :div, "#{year}", class: 'cal__year'
      concat content_tag :div, "#{date}", class: 'cal__date'
    end
  end
end