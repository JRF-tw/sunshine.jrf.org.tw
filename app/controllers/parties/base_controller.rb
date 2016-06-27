class Parties::BaseController < ApplicationController
  layout 'party'
  before_action :authenticate_party!
  before_action :set_phone?

  def index
  end

  def profile
  end

  def edit_email
    prev_unconfirmed_email = current_party.unconfirmed_email if current_party.respond_to?(:unconfirmed_email)
  end

  def update_email
    context = Party::ChangeEmailContext.new(current_party)
    if context.perform(params[:party])
      redirect_to parties_profile_path, flash: { success: "email已修改" }
    else
      redirect_to parties_edit_email_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end


  private

  def set_phone?
    redirect_to new_parties_phone_path unless current_party.phone_number.present?
  end

end
