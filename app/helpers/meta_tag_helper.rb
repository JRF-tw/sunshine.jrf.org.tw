module MetaTagHelper
  def set_meta(data = {})
    url = data[:url] || url_for(params.merge(host: Setting.host))
    data[:title] ||= default_meta[:title]
    data[:description] ||= default_meta[:description]
    data[:keywords] ||= default_meta[:keywords]
    data[:site] ||= default_meta[:site]
    data[:og] = {
      title: (data[:title] || data[:site]),
      description: data[:description],
      url: url,
      type: data[:og_type] || default_meta[:og_type]
    }
    data[:fb] = {
      :app_id => default_meta[:fb_app_id],
      :admins => default_meta[:fb_admin_ids]
    }
    data[:og][:image] = data[:image] if data[:image]
    set_meta_tags(data.merge(
      reverse: default_meta[:reverse], 
      separator: default_meta[:separator], 
      canonical: url,
      viewport: default_meta[:viewport]
    ))
  end

  def default_meta
    { title: "My app",
      viewport: "width=device-width, initial-scale=1.0, user-scalable=no",
      description: "5Fpro awesome!",
      keywords: "5fpro",
      fb_app_id: "12341234",
      fb_admin_ids: "1234,123",
      separator: " | ",
      reverse: true,
      og_type: "website",
      site: "司法陽光網"
    }
  end
end