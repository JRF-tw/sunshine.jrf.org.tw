class Admin::AwardsController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :award
  before_action { add_crumb("#{owner_type}列表", polymorphic_path(@owner.class)) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", polymorphic_path(@owner)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的獎勵紀錄列表", polymorphic_path([@owner, :awards])) }

  def index
    @awards = @owner.awards.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的獎勵紀錄列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的獎勵紀錄"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的獎勵紀錄"
    add_crumb @admin_page_title, '#'
  end

  def create
    if award.save
      respond_to do |f|
        f.html { redirect_to polymorphic_path([@owner, :awards]), flash: { success: "#{@owner.name}的獎勵紀錄 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的獎勵紀錄"
          add_crumb @admin_page_title, '#'
          flash[:error] = award.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if award.update_attributes(award_params)
      redirect_to polymorphic_path([@owner, :awards]), flash: { success: "#{@owner.name}的獎勵紀錄 - 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的獎勵紀錄"
      add_crumb @admin_page_title, '#'
      flash[:error] = award.errors.full_messages
      render :edit
    end
  end

  def destroy
    if award.destroy
      redirect_to polymorphic_path([@owner, :awards]), flash: { success: "#{@owner.name}的獎勵紀錄 - 已刪除" }
    else
      flash[:error] = award.errors.full_messages
      redirect_to :back
    end
  end

  private

  def award
    @award ||= params[:id] ? @owner.awards.find(params[:id]) : @owner.awards.new(award_params)
  end

  def award_params
    params.fetch(:award, {}).permit(:profile_id, :award_type, :unit, :content, :publish_at_in_tw, :publish_at, :source, :source_link, :origin_desc, :memo, :is_hidden)
  end
end
