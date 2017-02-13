class Admin::ReviewsController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :review
  before_action { add_crumb("#{owner_type}列表", send("admin_#{owner_pluralize}_path")) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", send("admin_#{owner_singularize}_path", @owner.id)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的相關新聞評論列表", send("admin_#{owner_singularize}_reviews_path", @owner.id)) }

  def index
    @reviews = @owner.reviews.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的相關新聞評論列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的相關新聞評論"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的相關新聞評論"
    add_crumb @admin_page_title, '#'
  end

  def create
    if review.save
      respond_to do |f|
        f.html { redirect_to send("admin_#{owner_singularize}_reviews_path", @owner), flash: { success: "#{@owner.name}的相關新聞評論 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的相關新聞評論"
          add_crumb @admin_page_title, '#'
          flash[:error] = review.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if review.update_attributes(review_params)
      redirect_to send("admin_#{owner_singularize}_reviews_path", @owner), flash: { success: "#{@owner.name}的相關新聞評論 - 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的相關新聞評論"
      add_crumb @admin_page_title, '#'
      flash[:error] = review.errors.full_messages
      render :edit
    end
  end

  def destroy
    if review.destroy
      redirect_to send("admin_#{owner_singularize}_reviews_path", @owner), flash: { success: "#{@owner.name}的相關新聞評論 - 已刪除" }
    else
      flash[:error] = review.errors.full_messages
      redirect_to :back
    end
  end

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/admin\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def review
    @review ||= params[:id] ? @owner.reviews.find(params[:id]) : @owner.reviews.new(review_params)
  end

  def review_params
    params.fetch(:review, {}).permit(:@owner_id, :publish_at_in_tw, :publish_at, :name, :title, :content, :comment, :no, :source, :file, :memo, :is_hidden)
  end
end
