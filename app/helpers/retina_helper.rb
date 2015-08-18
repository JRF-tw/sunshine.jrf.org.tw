module RetinaHelper
  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "##{icon}"
    end
  end
end