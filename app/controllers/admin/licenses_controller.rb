class Admin::LicensesController < Admin::BaseController
  before_action :license
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的專業證書列表", admin_profile_licenses_path(@profile)) }

  def index
    @licenses = @profile.licenses.all.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的專業證書列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的專業證書"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的專業證書 - #{license.title}"
    add_crumb @admin_page_title, "#"
  end

  def create
    if license.save
        respond_to do |f|
          f.html { redirect_to admin_profile_licenses_path(@profile), flash: { success: "#{@profile.name}的專業證書 - #{license.title} 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@profile.name}的專業證書"
          add_crumb @admin_page_title, "#"
          flash[:error] = license.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if license.update_attributes(license_params)
      redirect_to admin_profile_licenses_path(@profile), flash: { success: "#{@profile.name}的專業證書 - #{license.title} 已修改" }
    else
      @admin_page_title = "編輯#{@profile.name}的專業證書 - #{license.title}"
      add_crumb @admin_page_title, "#"
      flash[:error] = license.errors.full_messages
      render :edit
    end
  end

  def destroy
    if license.destroy
      redirect_to admin_profile_licenses_path(@profile), flash: { success: "#{@profile.name}的專業證書 - #{license.title} 已刪除" }
    else
      flash[:error] = license.errors.full_messages
      redirect_to :back
    end
  end

  private

  def license
    @profile = Admin::Profile.find params[:profile_id]
    @license ||= params[:id] ? @profile.licenses.find(params[:id]) : @profile.licenses.new(license_params)
  end

  def license_params
    params.fetch(:admin_license, {}).permit(:profile_id, :license_type, :unit, :title, :publish_at, :source, :source_link, :origin_desc, :memo)
  end
end
