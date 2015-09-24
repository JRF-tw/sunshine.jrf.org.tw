# encoding: utf-8

class BannerPicLUploader < BaseUploader
  version :large  do
    process :resize_to_fill => [540, 540]
  end

  version :middle do
    process :resize_to_fill => [360, 360]
  end

  version :small do
    process :resize_to_fill => [240, 240]
  end

  version :thumb do
    process :resize_to_fill => [180, 180]
  end
end