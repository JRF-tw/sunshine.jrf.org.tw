# encoding: utf-8

class BulletinPicUploader < BaseUploader
  weights = %w(360 540 720 900 1080 1296 1512 1728)
  weights.each do |w|
    w = w.to_i
    version "W_#{w}".to_sym do
      process resize_to_fill: [w, w * 2 / 3]
    end
  end
end
