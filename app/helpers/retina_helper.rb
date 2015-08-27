module RetinaHelper

  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "#icon-#{icon}"
    end
  end
  
  def rias_holder(name)
    tag :img, class: "#{name} lazyload", alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end

  def rias_srcset(asset_path, sizes, name)
    _src  = asset_path.gsub(/\./) { |match| "-#{sizes.min}." }  # 最小的當 fallback 圖片
    _path = gulp_asset_path("images/#{asset_path}") # 其他尺寸的要抓出完整路徑來處理

    image_tag _src, class: "#{name} lazyload",
      'data-sizes'  => 'auto',
      'data-srcset' => _path.gsub(/\./) { |match| '-{width}.' },
      'data-widths' => sizes.to_s # 縮放後的尺寸列表以陣列來帶入

    # 所有的正規表示式都只是在把寬度塞進副檔名前
    # eg. filename.jpg -> filename-300.jpg
  end

end