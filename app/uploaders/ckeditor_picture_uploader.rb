# encoding: utf-8
class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  use_file = Rails.env.test? || Rails.env.development?
  storage use_file ? :file : :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :extract_dimensions

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [118, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

  version :W_288 do
    process resize_to_fill: [288, 158]
  end

  version :W_722 do
    process resize_to_limit: [722, 401]
  end

  version :W_1018 do
    process resize_to_fill: [1018, 565]
  end

  version :W_1260 do
    process resize_to_limit: [1260, 700]
  end

  version :W_1501 do
    process resize_to_limit: [1501, 833]
  end

  version :W_1706 do
    process resize_to_limit: [1706, 947]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.image_file_types
  end
end
