module TemplateHelper
  def calendar(year, date)
    content_tag :time, class: 'cal' do
      concat content_tag :div, year.to_s, class: 'cal__year'
      concat content_tag :div, date.to_s, class: 'cal__date'
    end
  end

  def kv_cell(key, value)
    concat content_tag :dt, key.to_s, class: 'term'
    content_tag :dd, value.to_s, class: 'desc'
  end

  def inline_svg(icon)
    content_tag :svg, class: "icon-#{icon} icon" do
      tag :use, 'xlink:href' => "#icon-#{icon}"
    end
  end

  def rwd_generate(html_content)
    html_content.scan(/<img\salt.+\/>/).each { |img_tag|
      html_content = html_content.gsub(img_tag, img_html_generate(img_tag))
    }
    html_content
  end

  private

  def img_html_generate(image_tag)
    image_url = image_tag[/\/\/.+\.(jpg|png)/]
    "<img alt='' class='lazyload' data-sizes='auto' data-srcset=\"#{all_size_srcset(image_url)}\" src=\"#{image_url}\"/>"
  end

  def all_size_srcset(image_url)
    weights = %w(360 540 720 900 1080 1296 1512 1728 1944 2160 2592)
    weights.map { |w| "#{img_resize_url(image_url, w)} #{w}w" }.join(',')
  end

  def img_resize_url(image_url, size)
    width = image_url.split('/').last[/W_\d+/]
    image_url.gsub(width, "W_#{size}")
  end
end
