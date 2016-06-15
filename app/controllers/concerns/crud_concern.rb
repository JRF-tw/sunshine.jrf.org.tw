module CrudConcern

  private

  def render_as_fail(action, error_messages = nil)
    public_send(action)
    flash.now[:error] = error_messages if error_messages
    render action
  end

  def redirect_as_success(url, message = nil)
    flash_opts = message ? { success: message } : nil
    redirect_to params[:redirect_to] || url, flash: flash_opts
  end

  def redirect_as_fail(url, message = nil)
    flash_opts = message ? { error: message } : nil
    redirect_to params[:redirect_to] || url, flash: flash_opts
  end
end
