class Bystanders::PasswordsController < Devise::PasswordsController

protected
  def after_sign_in_path_for(resource_or_scope)
    bystanders_root_path
  end
end

