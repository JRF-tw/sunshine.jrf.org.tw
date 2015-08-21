module RetinaHelper
  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "##{icon}"
    end
  end
  def rias_holder
    tag :img, class: 'lazyload', alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end
end