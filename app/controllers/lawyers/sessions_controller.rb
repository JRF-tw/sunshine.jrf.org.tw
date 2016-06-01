class Lawyers::SessionsController < Devise::SessionsController
  layout 'lawyer'

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_lawyer_session_path
  end
end
