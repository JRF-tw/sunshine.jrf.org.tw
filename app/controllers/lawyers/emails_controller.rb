class Lawyers::EmailsController < Lawyers::BaseController
  before_action :find_lawyer, only: [:edit, :update]

  def edit
  end

  def update
    context = Lawyer::ChangeEmailContext.new(@lawyer)
    if context.perform(params)
      flash[:notice] = "需要重新驗證新的Email"
      redirect_to lawyer_profile_path
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

  def find_lawyer
    @lawyer ||= Lawyer.find(current_lawyer.id)
  end
end
