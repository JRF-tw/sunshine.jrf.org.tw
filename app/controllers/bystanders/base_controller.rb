class Bystanders::BaseController  < ApplicationController
  include CrudConcern
  
  before_action :authenticate_bystander!

  layout 'bystander'

  def index
  end

  def profile
  end

  def send_reset_password_mail
    context = Bystander::SendSetPasswordEmailContext.new(current_bystander)
    context.perform
    redirect_as_success(bystanders_profile_path, "觀察者 - #{current_bystander.name} 重設密碼信件已寄出")
  end
end
