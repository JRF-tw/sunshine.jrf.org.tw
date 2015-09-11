module RetinaHelper

  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "#icon-#{icon}"
    end
  end
  
  def rias_holder(name)
    tag :img, class: "#{name} lazyload", alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end

  def image_srcset(source, sizes, name)
    _src   = source.gsub(/\./) { |match| "-#{sizes.min}." }  # 最小的當 fallback 圖片
    _paths = []
    
    # 把每個尺寸加入 srcset 的檔名跟 w 指示
    sizes.each do |size|
      file = source.gsub(/\./) { |match| "-#{size}." }
      path = gulp_asset_path("images/#{file}")
      _paths.push "#{path} #{size}w"
    end

    image_tag _src, class: "#{name} lazyload",
      'data-sizes'  => 'auto',
      'data-srcset' => _paths.join(",")

    # 所有的正規表示式都只是在把寬度塞進副檔名前
    # eg. filename.jpg -> filename-300.jpg
  end

end