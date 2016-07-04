# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  url        :string
#  alt_string :string
#  title      :string
#  content    :text
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Admin::SuitBannersController < Admin::BaseController
  before_action :suit_banner
  before_action(except: [:index]) { add_crumb("司法案例面面觀 banner 列表", admin_suit_banners_path) }

  def index
    @suit_banners = SuitBanner.all.order_by_weight.page(params[:page]).per(10)
    @admin_page_title = "司法案例面面觀 banner 列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增司法案例面面觀 banner"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯司法案例面面觀 banner"
    add_crumb @admin_page_title, "#"
  end

  def create
    if suit_banner.save
      respond_to do |f|
        f.html { redirect_to admin_suit_banners_path, flash: { success: "司法案例面面觀 banner 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增司法案例面面觀 banner"
          add_crumb @admin_page_title, "#"
          flash[:error] = suit_banner.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if suit_banner.update_attributes(suit_banner_params)
      redirect_to admin_suit_banners_path, flash: { success: "司法案例面面觀 banner 已修改" }
    else
      @admin_page_title = "編輯司法案例面面觀 banner"
      add_crumb @admin_page_title, "#"
      flash[:error] = suit_banner.errors.full_messages
      render :edit
    end
  end

  def destroy
    if suit_banner.destroy
      redirect_to admin_suit_banners_path, flash: { success: "司法案例面面觀 banner 已刪除" }
    else
      flash[:error] = suit_banner.errors.full_messages
      redirect_to :back
    end
  end

  private

  def suit_banner
    @suit_banner ||= params[:id] ? Admin::SuitBanner.find(params[:id]) : Admin::SuitBanner.new(suit_banner_params)
  end

  def suit_banner_params
    params.fetch(:admin_suit_banner, {}).permit(:pic_l, :pic_m, :pic_s, :url, :alt_string, :title, :content, :weight, :is_hidden)
  end
end
