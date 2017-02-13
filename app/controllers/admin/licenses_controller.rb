class Admin::LicensesController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :license
  before_action { add_crumb("#{owner_type}列表", send("admin_#{owner_pluralize}_path")) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", send("admin_#{owner_singularize}_path", @owner.id)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的專業證書列表", send("admin_#{owner_singularize}_licenses_path", @owner.id)) }

  def index
    @licenses = @owner.licenses.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的專業證書列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的專業證書"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的專業證書 - #{license.title}"
    add_crumb @admin_page_title, '#'
  end

  def create
    if license.save
      respond_to do |f|
        f.html { redirect_to send("admin_#{owner_singularize}_licenses_path", @owner), flash: { success: "#{@owner.name}的專業證書 - #{license.title} 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的專業證書"
          add_crumb @admin_page_title, '#'
          flash[:error] = license.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if license.update_attributes(license_params)
      redirect_to send("admin_#{owner_singularize}_licenses_path", @owner), flash: { success: "#{@owner.name}的專業證書 - #{license.title} 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的專業證書 - #{license.title}"
      add_crumb @admin_page_title, '#'
      flash[:error] = license.errors.full_messages
      render :edit
    end
  end

  def destroy
    if license.destroy
      redirect_to send("admin_#{owner_singularize}_licenses_path", @owner), flash: { success: "#{@owner.name}的專業證書 - #{license.title} 已刪除" }
    else
      flash[:error] = license.errors.full_messages
      redirect_to :back
    end
  end

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/admin\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def license
    @license ||= params[:id] ? @owner.licenses.find(params[:id]) : @owner.licenses.new(license_params)
  end

  def license_params
    params.fetch(:license, {}).permit(:profile_id, :license_type, :unit, :title, :publish_at_in_tw, :publish_at, :source, :source_link, :origin_desc, :memo, :is_hidden)
  end
end
