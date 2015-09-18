class Admin::ProceduresController < Admin::BaseController
  before_action :procedure
  before_action{ add_crumb("評鑑資料 - 案例列表", admin_suits_path) }
  before_action{ add_crumb("#{@suit.title}的評鑑資料 - 案例", admin_suit_path(@suit)) }
  before_action(except: [:index]){ add_crumb("#{@suit.title}的案例處理經過列表", admin_suit_procedures_path(@suit)) }

  def index
    @procedures = @suit.procedures.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@suit.title}的案例處理經過列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@suit.title}的案例處理經過"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@suit.title}的案例處理經過"
    add_crumb @admin_page_title, "#"
  end

  def create
    if procedure.save
        respond_to do |f|
          f.html { redirect_to admin_suit_procedures_path(@suit), flash: { success: "#{@suit.title}的案例處理經過 - 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@suit.title}的案例處理經過"
          add_crumb @admin_page_title, "#"
          flash[:error] = procedure.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if procedure.update_attributes(procedure_params)
      redirect_to admin_suit_procedures_path(@suit), flash: { success: "#{@suit.title}的案例處理經過 - 已修改" }
    else
      @admin_page_title = "編輯#{@suit.title}的案例處理經過"
      add_crumb @admin_page_title, "#"
      flash[:error] = procedure.errors.full_messages
      render :edit
    end
  end

  def destroy
    if procedure.destroy
      redirect_to admin_suit_procedures_path(@suit), flash: { success: "#{@suit.title}的案例處理經過 - 已刪除" }
    else
      flash[:error] = procedure.errors.full_messages
      redirect_to :back
    end
  end

  private

  def procedure
    @suit = Admin::Suit.find params[:suit_id]
    @procedure ||= params[:id] ? @suit.procedures.find(params[:id]) : @suit.procedures.new(procedure_params)
  end

  def procedure_params
    params.fetch(:admin_procedure, {}).permit(:profile_id, :suit_id, :unit, :title, :procedure_unit, :procedure_content, :procedure_result, :procedure_no, :procedure_date_in_tw, :procedure_date, :suit_no, :source, :source_link, :punish_link, :file, :memo)
  end
end