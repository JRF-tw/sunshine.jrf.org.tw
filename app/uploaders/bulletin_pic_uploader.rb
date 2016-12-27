# encoding: utf-8

class BulletinPicUploader < BaseUploader
  weights = %w(360 720)
  weights.each do |w|
    w = w.to_i
    version "W_#{w}".to_sym do
      process resize_to_fill: [w, w * 2 / 3]
    end
  end
end
