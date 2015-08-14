module ApplicationHelper
  def gulp_asset_path(path)
    path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
    "/assets/#{path}"
  end

  def image_alt(src)
    super.sub(/\s[0-9A-F]{8}\z/i, '')
  end

  def image_tag(image, options = {})
    super(gulp_asset_path("images/#{image}"), options)
  end
end