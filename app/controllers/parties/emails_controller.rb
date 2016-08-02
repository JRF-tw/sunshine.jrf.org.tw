class Parties::EmailsController < Parties::BaseController
  def edit
    # prev_unconfirmed_email = current_party.unconfirmed_email if current_party.respond_to?(:unconfirmed_email)
  end

  def update
    context = Party::ChangeEmailContext.new(current_party)
    if context.perform(params)
      flash[:notice] = "需要重新驗證新的Email"
      redirect_to party_profile_path
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

end
