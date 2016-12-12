Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RedactorRails::Engine => '/redactor_rails'

  load Rails.root.join('config/routes/classic/devise.rb')
  load Rails.root.join('config/routes/classic/base.rb')

  unless Rails.env.production?
    load Rails.root.join('config/routes/devise.rb')
    load Rails.root.join('config/routes/base.rb')
    load Rails.root.join('config/routes/observer.rb')
    load Rails.root.join('config/routes/lawyer.rb')
    load Rails.root.join('config/routes/party.rb')
  end

  load Rails.root.join('config/routes/api.rb')
  load Rails.root.join('config/routes/admin/admin.rb')

  # routes exception to 404
  get '*unmatched_route', to: 'base#render_404', via: :all
end
