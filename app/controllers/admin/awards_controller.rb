class Admin::AwardsController < Admin::BaseController
  before_action :award
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的獎勵記錄列表", admin_profile_awards_path(@profile)) }

  def index
    @awards = @profile.awards.all.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的獎勵記錄列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的獎勵記錄"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的獎勵記錄"
    add_crumb @admin_page_title, "#"
  end

  def create
    if award.save
        respond_to do |f|
          f.html { redirect_to admin_profile_awards_path(@profile), flash: { success: "#{@profile.name}的獎勵記錄 - 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html { render :new, flash: { error: award.errors.full_messages } }
        f.js { render }
      end
    end
  end

  def update
    if award.update_attributes(award_params)
      redirect_to admin_profile_awards_path(@profile), flash: { success: "#{@profile.name}的獎勵記錄 - 已修改" }
    else
      render :edit, flash: { error: award.errors.full_messages }
    end
  end

  def destroy
    if award.destroy
      redirect_to admin_profile_awards_path(@profile), flash: { success: "#{@profile.name}的獎勵記錄 - 已刪除" }
    else
      redirect_to :back, flash: { error: award.errors.full_messages }
    end
  end

  private

  def award
    @profile = Admin::Profile.find params[:profile_id]
    @award ||= params[:id] ? @profile.awards.find(params[:id]) : @profile.awards.new(award_params)
  end

  def award_params
    params.fetch(:admin_award, {}).permit(:profile_id, :award_type, :unit, :content, :publish_at, :source, :source_link, :origin_desc, :memo)
  end
end