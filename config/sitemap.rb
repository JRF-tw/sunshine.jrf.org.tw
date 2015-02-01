SitemapGenerator::Sitemap.default_host = "http://#{Setting.host}"
# mapping to robots.txt
SitemapGenerator::Sitemap.sitemaps_host = "http://#{Setting.assets_host}/"
SitemapGenerator::Sitemap.sitemaps_path = Setting.sitemap.path
SitemapGenerator::Sitemap.public_path = "public/"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.include_index = true
SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
