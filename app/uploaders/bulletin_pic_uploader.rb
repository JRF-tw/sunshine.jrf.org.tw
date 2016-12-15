# encoding: utf-8

class BulletinPicUploader < BaseUploader
  version :L_360 do
    process resize_to_fill: [360, 180]
  end
end
