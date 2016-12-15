# encoding: utf-8

class AvatarUploader < BaseUploader
  version :L_540 do
    process resize_to_fill: [540, 540]
  end

  version :L_360 do
    process resize_to_fill: [360, 360]
  end

  version :L_240 do
    process resize_to_fill: [240, 240]
  end

  version :L_180 do
    process resize_to_fill: [180, 180]
  end
end
