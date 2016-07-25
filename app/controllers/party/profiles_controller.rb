class Party::ProfilesController < Party::BaseController
  def show
  end

  def edit
  end

  def update
    context = Party::UpdateProfileContext.new(current_party)
    if context.perform(params[:party])
      redirect_to party_profile_path, flash: { success: "個人資訊已修改" }
    else
      redirect_to :back, flash: { notice: context.error_messages.join(", ") }
    end
  end
end
