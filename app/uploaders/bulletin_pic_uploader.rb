# encoding: utf-8

class BulletinPicUploader < BaseUploader
  version :S_280 do
    process resize_to_fill: [280, 140]
  end

  version :S_540 do
    process resize_to_fill: [540, 270]
  end

  version :S_780 do
    process resize_to_fill: [780, 390]
  end
end
