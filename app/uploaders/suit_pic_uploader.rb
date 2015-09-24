# encoding: utf-8

class SuitPicUploader < BaseUploader
  version :xlarge  do
    process :resize_to_fill => [1512, 1145]
  end

  version :large  do
    process :resize_to_fill => [1080, 818]
  end

  version :middle do
    process :resize_to_fill => [900, 682]
  end

  version :small do
    process :resize_to_fill => [720, 545]
  end

  version :xsmall do
    process :resize_to_fill => [540, 409]
  end

  version :thumb do
    process :resize_to_fill => [360, 273]
  end
end