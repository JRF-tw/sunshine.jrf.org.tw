# encoding: utf-8

class BannerPicSUploader < BaseUploader
  version :S_2592 do
    process resize_to_fill: [2592, 3888]
  end

  version :S_2160 do
    process resize_to_fill: [2160, 3240]
  end

  version :S_1944 do
    process resize_to_fill: [1944, 2916]
  end

  version :S_1728 do
    process resize_to_fill: [1728, 2592]
  end

  version :S_1512 do
    process resize_to_fill: [1512, 2268]
  end

  version :S_1296 do
    process resize_to_fill: [1296, 1944]
  end

  version :S_1080 do
    process resize_to_fill: [1080, 1620]
  end

  version :S_900 do
    process resize_to_fill: [900, 1350]
  end

  version :S_720 do
    process resize_to_fill: [720, 1080]
  end

  version :S_540 do
    process resize_to_fill: [540, 810]
  end

  version :S_360 do
    process resize_to_fill: [360, 540]
  end

  weights = %w(360 540 720 900 1080 1296 1512 1728 1944 2160 2592)
  weights.each do |w|
    w = w.to_i
    version "W_#{w}".to_sym do
      process resize_to_fill: [w, w * 2 / 3]
    end
  end
end
