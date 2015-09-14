# encoding: utf-8

class SuitPicUploader < BaseUploader
  version :thumb do
    process :resize_to_fit => [200, 200]
  end
end