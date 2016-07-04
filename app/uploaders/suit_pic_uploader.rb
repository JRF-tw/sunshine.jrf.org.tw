# encoding: utf-8

class SuitPicUploader < BaseUploader
  version :L_1512 do
    process resize_to_fill: [1512, 1145]
  end

  version :L_1080 do
    process resize_to_fill: [1080, 818]
  end

  version :L_900 do
    process resize_to_fill: [900, 682]
  end

  version :L_720 do
    process resize_to_fill: [720, 545]
  end

  version :L_540 do
    process resize_to_fill: [540, 409]
  end

  version :L_360 do
    process resize_to_fill: [360, 273]
  end
end
