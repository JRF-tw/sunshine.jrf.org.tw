module RetinaHelper

  def rias_holder(name)
    tag :img, class: "#{name} lazyload", alt: '', 'data-sizes' => 'auto', 'data-src' => 'http://placehold.it/{width}'
  end

  def rias_srcset(source, sizes, name)
    image_src  = source.sub(/[^\/]*$/) { |matched| "L_#{sizes.min}_#{matched}" } # the smallest should be fallback pic
    image_file = source.sub(/[^\/]*$/) { |matched| "L_{width}_#{matched}" }
    path = path_to_image image_file # get other size pic full_path

    image_tag image_src, class: "#{name} lazyload", 'data-sizes': 'auto', 'data-srcset': path, 'data-widths': sizes.to_s # after scaled, size will be Array
  end

  def rwd_image(image)
    image_tag\
      image[:src],
      alt: (image[:alt] if image[:alt]),
      class: [(image[:class] if image[:class]), 'lazyload'],
      'data-sizes' => 'auto',
      'data-srcset' => image[:srcset].join(',')
  end

  def source_srcset(source, size, media)
    image_file = source.sub(/[^\/]*$/) { |matched| "#{size}_{width}_#{matched}" }
    path = path_to_image image_file.to_s

    tag :source,
        'data-srcset' => path,
        'media'       => media
  end

end
