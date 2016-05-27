class Bystander::PasswordsController < Devise::PasswordsController

protected
  def after_sign_in_path_for(resource_or_scope)
    bystanders_path
  end
end

