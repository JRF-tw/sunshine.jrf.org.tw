# encoding: utf-8

class BulletinPicUploader < BaseUploader
  version :W_255 do
    process resize_to_fill: [255, 170]
  end

  version :W_656 do
    process resize_to_fill: [656, 437]
  end
end
