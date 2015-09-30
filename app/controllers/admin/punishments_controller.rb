class Admin::PunishmentsController < Admin::BaseController
  before_action :punishment
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的懲處紀錄列表", admin_profile_punishments_path(@profile)) }

  def index
    @punishments = @profile.punishments.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的懲處紀錄列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的懲處紀錄"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的懲處紀錄"
    add_crumb @admin_page_title, "#"
  end

  def create
    if punishment.save
        respond_to do |f|
          f.html { redirect_to admin_profile_punishments_path(@profile), flash: { success: "#{@profile.name}的懲處紀錄 - 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@profile.name}的懲處紀錄"
          add_crumb @admin_page_title, "#"
          flash[:error] = punishment.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if punishment.update_attributes(punishment_params)
      redirect_to admin_profile_punishments_path(@profile), flash: { success: "#{@profile.name}的懲處紀錄 - 已修改" }
    else
      @admin_page_title = "編輯#{@profile.name}的懲處紀錄"
      add_crumb @admin_page_title, "#"
      flash[:error] = punishment.errors.full_messages
      render :edit
    end
  end

  def destroy
    if punishment.destroy
      redirect_to admin_profile_punishments_path(@profile), flash: { success: "#{@profile.name}的懲處紀錄 - 已刪除" }
    else
      flash[:error] = punishment.errors.full_messages
      redirect_to :back
    end
  end

  private

  def punishment
    @profile = Admin::Profile.find params[:profile_id]
    @punishment ||= params[:id] ? @profile.punishments.find(params[:id]) : @profile.punishments.new(punishment_params)
  end

  def punishment_params
    params.fetch(:admin_punishment, {}).permit(:profile_id, :decision_unit, :unit, :title, :claimant, :punish_no, :decision_no, :punish_type, :relevant_date_in_tw, :relevant_date, :decision_result, :decision_source, :reason, :is_anonymous, :anonymous_source, :anonymous, :origin_desc, :proposer, :plaintiff, :defendant, :reply, :reply_source, :punish, :content, :summary, :memo)
  end
end
