class Lawyer::BaseController < ApplicationController
  include CrudConcern

  layout 'lawyer'
  before_action :authenticate_lawyer!, except: :index
  # before_action :check_profile!, except: [:profile, :edit_profile, :update_profile]

  def index
  end

  def profile
  end

  def edit_profile
  end

  def update_profile
    context = Lawyer::UpdateProfileContext.new(current_lawyer)
    if context.perform(params[:lawyer])
      redirect_to lawyer_profile_path, flash: { success: "個人資訊已修改" }
    else
      render :back, flash: { notice: context.error_messages.join(", ") }
    end
  end

  # private
  # 其他action可能會用到
  # def check_profile!
  #   if current_lawyer.need_update_info?
  #     flash[:notice] = "請更新完整資料"
  #     redirect_to lawyer_edit_profile_path if current_lawyer.need_update_info?
  #   end
  # end
end
