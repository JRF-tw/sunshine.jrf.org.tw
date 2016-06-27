class Lawyer::BaseController < ApplicationController
  include CrudConcern

  layout 'lawyer'
  before_action :authenticate_lawyer!, except: :index
  # before_action :check_profile!, except: [:profile, :edit_profile, :update_profile]

  def index
  end

  # private
  # 其他action可能會用到
  # def check_profile!
  #   if current_lawyer.need_update_info?
  #     flash[:notice] = "請更新完整資料"
  #     redirect_to edit_lawyer_profile_path if current_lawyer.need_update_info?
  #   end
  # end
end
