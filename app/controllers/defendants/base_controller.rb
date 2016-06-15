class Defendants::BaseController < ApplicationController
  layout 'defendant'
  before_action :authenticate_defendant!
  before_action :phone_confirmed?

  def index
  end

  def profile
  end

  def edit_email
    prev_unconfirmed_email = current_bystander.unconfirmed_email if current_bystander.respond_to?(:unconfirmed_email)
  end

  def update_email
    context = Defendant::ChangeEmailContext.new(current_defendant)
    if context.perform(params[:defendant])
      redirect_to defendants_profile_path, flash: { success: "email已修改" }
    else
      redirect_to defendants_edit_email_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  private

  def phone_confirmed?
    redirect_to new_defendants_phone_path unless current_defendant.phone_number.present?
  end

end
