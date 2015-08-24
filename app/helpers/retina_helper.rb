module RetinaHelper

  def inline_svg(icon)
    content_tag :svg, class: "#{icon} icon" do
      tag :use, "xlink:href" => "##{icon}"
    end
  end
  
  def rias_holder(name)
    tag :img, class: "lazyload #{name}", alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end

  def image_srcset(asset_path, sizes, name)
    tag :img, class: "lazyload #{name}", 'data-sizes' => 'auto', 'data-srcset' => rwd_srcset(gulp_asset_path("images/#{asset_path}"), sizes)
  end

  def rwd_srcset(asset_path, sizes)
    srcset = []
    sizes.each do |size|
      dest_path = asset_path.gsub(/\./) { |match| "-#{size}." }
      srcset.push "#{dest_path} #{size}w"
    end
    return srcset.join ', '
  end

end