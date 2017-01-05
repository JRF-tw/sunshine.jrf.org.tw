# encoding: utf-8

class BannerPicMUploader < BaseUploader
  version :M_2592 do
    process resize_to_fill: [2592, 1688]
  end

  version :M_2160 do
    process resize_to_fill: [2160, 1407]
  end

  version :M_1944 do
    process resize_to_fill: [1944, 1266]
  end

  version :M_1728 do
    process resize_to_fill: [1728, 1125]
  end

  version :M_1512 do
    process resize_to_fill: [1512, 985]
  end

  version :M_1296 do
    process resize_to_fill: [1296, 844]
  end

  version :M_1080 do
    process resize_to_fill: [1080, 703]
  end

  version :M_900 do
    process resize_to_fill: [900, 586]
  end

  version :M_720 do
    process resize_to_fill: [720, 469]
  end

  version :M_540 do
    process resize_to_fill: [540, 352]
  end

  version :M_360 do
    process resize_to_fill: [360, 234]
  end
end
