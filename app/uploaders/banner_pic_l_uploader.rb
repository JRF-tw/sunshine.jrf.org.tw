# encoding: utf-8

class BannerPicLUploader < BaseUploader
  version :L_2592  do
    process :resize_to_fill => [2592, 1296]
  end

  version :L_2160  do
    process :resize_to_fill => [2160, 1080]
  end

  version :L_1944  do
    process :resize_to_fill => [1944, 972]
  end

  version :L_1728  do
    process :resize_to_fill => [1728, 864]
  end

  version :L_1512  do
    process :resize_to_fill => [1512, 756]
  end

  version :L_1296  do
    process :resize_to_fill => [1296, 648]
  end

  version :L_1080  do
    process :resize_to_fill => [1080, 540]
  end

  version :L_900  do
    process :resize_to_fill => [900, 450]
  end

  version :L_720  do
    process :resize_to_fill => [720, 360]
  end

  version :L_540  do
    process :resize_to_fill => [540, 270]
  end

  version :L_360  do
    process :resize_to_fill => [360, 180]
  end
end