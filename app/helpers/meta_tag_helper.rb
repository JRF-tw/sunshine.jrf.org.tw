module MetaTagHelper
  def init_meta(options = {})
    data = {}
    url =  options[:url] || url_for(params.merge(host: Setting.host))
    data[:title] = match_title(options[:title]) || default_meta[:title]
    data[:description] = match_description(options[:description]) || default_meta[:description]
    data[:keywords] = match_keywords(options[:keywords]) || default_meta[:keywords]
    data[:site] ||= default_meta[:site]
    data[:og] = {
      title: (data[:title] || data[:site]),
      description: data[:description],
      url: url,
      type: options[:og_type] || default_meta[:og_type]
    }
    data[:fb] = {
      app_id: default_meta[:fb_app_id],
      admins: default_meta[:fb_admin_ids]
    }
    data[:og][:image] = options[:image] if options[:image]
    set_meta_tags(data.merge(
                    reverse: default_meta[:reverse],
                    separator: default_meta[:separator],
                    canonical: url,
                    viewport: default_meta[:viewport]
    ))
  end

  def default_meta
    { title: 'My app',
      viewport: 'width=device-width, initial-scale=1.0, user-scalable=no',
      description: '5Fpro awesome!',
      keywords: '5fpro',
      fb_app_id: '12341234',
      fb_admin_ids: '1234,123',
      separator: ' | ',
      reverse: true,
      og_type: 'website',
      site: '司法陽光網' }
  end

  private

  def prefix_meta_key_pattern(last_key)
    "meta.#{params[:controller]}.#{params[:action]}.#{last_key}"
  end

  def check_i18n_key(last_key)
    I18n.exists?(prefix_meta_key_pattern(last_key).to_s, I18n.default_locale)
  end

  def match_title(hash)
    check_i18n_key('title') ? I18n.t(prefix_meta_key_pattern('title').to_s, hash) : nil
  end

  def match_description(hash)
    check_i18n_key('description') ? I18n.t(prefix_meta_key_pattern('description').to_s, hash) : nil
  end

  def match_keywords(hash)
    check_i18n_key('keywords') ? I18n.t(prefix_meta_key_pattern('keywords').to_s, hash) : nil
  end
end
