class Lawyers::SessionsController < Devise::SessionsController
  layout 'lawyer'

  def new
    set_meta
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.need_update_info?
      flash[:notice] = '請更新完整資料'
      redirect_to edit_lawyer_profile_path
    else
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  protected

  def after_sign_out_path_for(_resource_or_scope)
    new_lawyer_session_path
  end
end
