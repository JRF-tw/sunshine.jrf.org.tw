class Lawyers::ProfilesController < Lawyers::BaseController
  layout "lawyer"

  # TODO: Layout render error

  def show
  end

  def edit
  end

  def update
    context = Lawyer::UpdateProfileContext.new(current_lawyer)
    if context.perform(params[:lawyer])
      redirect_to lawyer_profile_path, flash: { success: "個人資訊已修改" }
    else
      redirect_to :back, flash: { notice: context.error_messages.join(", ") }
    end
  end
end
