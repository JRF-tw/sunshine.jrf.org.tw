class Party::EmailsController < Party::BaseController
  def edit
    prev_unconfirmed_email = current_party.unconfirmed_email if current_party.respond_to?(:unconfirmed_email)
  end

  def update
    context = Party::ChangeEmailContext.new(current_party)
    if context.perform(params[:party])
      redirect_to party_profile_path, flash: { success: "email已修改" }
    else
      redirect_to edit_party_email_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end
end
