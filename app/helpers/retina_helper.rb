module RetinaHelper

  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "#icon-#{icon}"
    end
  end
  
  def rias_holder(name)
    tag :img, class: "#{name} lazyload", alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end

  def rias_srcset(source, sizes, name)
    _src  = source.sub(/[^\/]*$/) { |matched| "L_#{sizes.min}_#{matched}" }  # 最小的當 fallback 圖片
    _file = source.sub(/[^\/]*$/) { |matched| "L_{width}_#{matched}" }
    path  = path_to_image _file # 其他尺寸的要抓出完整路徑來處理

    image_tag _src, class: "#{name} lazyload",
      'data-sizes'  => 'auto',
      'data-srcset' => path,
      'data-widths' => sizes.to_s # 縮放後的尺寸列表以陣列來帶入

  end

  def source_srcset(source, size, media)
    _file = source.sub(/[^\/]*$/) { |matched| "#{size}_{width}_#{matched}" }
    path  = path_to_image "#{_file}"
    
    tag :source,
      'data-srcset' => path,
      'media'       => media
  end

end