class Admin::PunishmentsController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :punishment
  before_action { add_crumb("#{owner_type}列表", polymorphic_path(@owner.class)) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", polymorphic_path(@owner)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的懲處紀錄列表", polymorphic_path([@owner, :punishments])) }

  def index
    @punishments = @owner.punishments.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的懲處紀錄列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的懲處紀錄"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的懲處紀錄"
    add_crumb @admin_page_title, '#'
  end

  def create
    if punishment.save
      respond_to do |f|
        f.html { redirect_to polymorphic_path([@owner, :punishments]), flash: { success: "#{@owner.name}的懲處紀錄 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的懲處紀錄"
          add_crumb @admin_page_title, '#'
          flash[:error] = punishment.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if punishment.update_attributes(punishment_params)
      redirect_to polymorphic_path([@owner, :punishments]), flash: { success: "#{@owner.name}的懲處紀錄 - 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的懲處紀錄"
      add_crumb @admin_page_title, '#'
      flash[:error] = punishment.errors.full_messages
      render :edit
    end
  end

  def destroy
    if punishment.destroy
      redirect_to polymorphic_path([@owner, :punishments]), flash: { success: "#{@owner.name}的懲處紀錄 - 已刪除" }
    else
      flash[:error] = punishment.errors.full_messages
      redirect_to :back
    end
  end

  private

  def punishment
    @punishment ||= params[:id] ? @owner.punishments.find(params[:id]) : @owner.punishments.new(punishment_params)
  end

  def punishment_params
    params.fetch(:punishment, {}).permit(:profile_id, :decision_unit, :unit, :title, :claimant, :punish_no, :decision_no, :punish_type, :relevant_date_in_tw, :relevant_date, :decision_result, :decision_source, :reason, :is_anonymous, :anonymous_source, :anonymous, :origin_desc, :proposer, :plaintiff, :defendant, :reply, :reply_source, :punish, :content, :summary, :status, :memo, :is_hidden)
  end
end
