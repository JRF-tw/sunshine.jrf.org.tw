# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( admin.css admin.js policies.js *.svg *.eot *.woff *.ttf *.map *.png *.jpg *.json)

Rails.application.config.assets.precompile += [/^[a-z0-9]\w+.(css|js|woff|eot|svg|ttf|map|png|jpg|gif|json)$/]
Rails.application.config.assets.precompile += %w( ckeditor/* )
