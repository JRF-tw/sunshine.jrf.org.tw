class Bystander::ProfilesController < Bystander::BaseController
  def show
  end

  def edit
  end

  def update
    context = Bystander::UpdateProfileContext.new(current_bystander)
    if context.perform(params[:bystander])
      redirect_to bystander_profile_path, flash: { success: "個人資訊已修改" }
    else
      redirect_to :back, flash: { notice: context.error_messages.join(", ") }
    end
  end
end
