class Admin::ArticlesController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :article
  before_action { add_crumb("#{owner_type}列表", polymorphic_path(@owner.class)) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", polymorphic_path(@owner)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的發表言論列表", polymorphic_path([@owner, :articles])) }

  def index
    @articles = @owner.articles.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的發表言論列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的發表言論"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的發表言論"
    add_crumb @admin_page_title, '#'
  end

  def create
    if article.save
      respond_to do |f|
        f.html { redirect_to polymorphic_path([@owner, :articles]), flash: { success: "#{@owner.name}的發表言論 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的發表言論"
          add_crumb @admin_page_title, '#'
          flash[:error] = article.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if article.update_attributes(article_params)
      redirect_to polymorphic_path([@owner, :articles]), flash: { success: "#{@owner.name}的發表言論 - 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的發表言論"
      add_crumb @admin_page_title, '#'
      flash[:error] = article.errors.full_messages
      render :edit
    end
  end

  def destroy
    if article.destroy
      redirect_to polymorphic_path([@owner, :articles]), flash: { success: "#{@owner.name}的發表言論 - 已刪除" }
    else
      flash[:error] = article.errors.full_messages
      redirect_to :back
    end
  end

  private

  def article
    @article ||= params[:id] ? @owner.articles.find(params[:id]) : @owner.articles.new(article_params)
  end

  def article_params
    params.fetch(:article, {}).permit(:article_type, :publish_year, :paper_publish_at_in_tw, :paper_publish_at, :news_publish_at_in_tw, :news_publish_at, :book_title, :title, :journal_no, :journal_periods, :start_page, :end_page, :editor, :author, :publisher, :publish_locat, :department, :degree, :source, :memo, :is_hidden)
  end
end
