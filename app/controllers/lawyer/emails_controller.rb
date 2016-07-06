class Lawyer::EmailsController < Lawyer::BaseController

  def edit

  end

  def update
    context = Lawyer::ChangeEmailContext.new(current_lawyer)
    if context.perform(params)
      flash[:notice] = "需要重新驗證新的Email"
      redirect_to lawyer_profile_url
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end
end
