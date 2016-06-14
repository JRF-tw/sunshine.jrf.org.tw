class Defendants::BaseController < ApplicationController
  layout 'defendant'
  before_action :authenticate_defendant!

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
      flash.now[:error] = context.error_messages.join(", ")
      render :edit_email
    end
  end

end
