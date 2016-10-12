Rails.application.routes.draw do
  mount RedactorRails::Engine => "/redactor_rails"

  load Rails.root.join('config/routes/devise.rb')
  load Rails.root.join('config/routes/f2e.rb')

  unless Rails.env.production?
    # ver2 routes
    load Rails.root.join('config/routes/devise_ver2.rb')
    load Rails.root.join('config/routes/f2e_ver2.rb')
    load Rails.root.join('config/routes/f2e_observer.rb')
    load Rails.root.join('config/routes/f2e_lawyer.rb')
    load Rails.root.join('config/routes/f2e_party.rb')
  end

  load Rails.root.join('config/routes/api.rb')
  load Rails.root.join('config/routes/admin.rb')
end
