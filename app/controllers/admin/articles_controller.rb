class Admin::ArticlesController < Admin::BaseController
  before_action :find_owner
  before_action :article
  before_action { add_crumb("#{owner_type}列表", send("admin_#{owner_pluralize}_path")) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", send("admin_#{owner_singularize}_path", @owner.id)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的發表言論列表", send("admin_#{owner_singularize}_articles_path", @owner.id)) }

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
        f.html { redirect_to send("admin_#{owner_singularize}_articles_path", @owner), flash: { success: "#{@owner.name}的發表言論 - 已新增" } }
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
      redirect_to send("admin_#{owner_singularize}_articles_path", @owner), flash: { success: "#{@owner.name}的發表言論 - 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的發表言論"
      add_crumb @admin_page_title, '#'
      flash[:error] = article.errors.full_messages
      render :edit
    end
  end

  def destroy
    if article.destroy
      redirect_to send("admin_#{owner_singularize}_articles_path", @owner), flash: { success: "#{@owner.name}的發表言論 - 已刪除" }
    else
      flash[:error] = article.errors.full_messages
      redirect_to :back
    end
  end

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/admin\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def article
    @article ||= params[:id] ? @owner.articles.find(params[:id]) : @owner.articles.new(article_params)
  end

  def article_params
    params.fetch(:article, {}).permit(:profile_id, :article_type, :publish_year, :paper_publish_at_in_tw, :paper_publish_at, :news_publish_at_in_tw, :news_publish_at, :book_title, :title, :journal_no, :journal_periods, :start_page, :end_page, :editor, :author, :publisher, :publish_locat, :department, :degree, :source, :memo, :is_hidden)
  end

  def owner_type
    case @owner.class.name.demodulize
    when 'Judge'
      '法官'
    when 'Prosecutor'
      '檢察官'
    end
  end

  def owner_id
    params["#{@owner_class.to_s.downcase.demodulize}_id"]
  end

  def owner_pluralize
    @owner_pluralize = @owner.class.to_s.downcase.demodulize.pluralize
  end

  def owner_singularize
    @owner_singularize = @owner.class.to_s.downcase.demodulize.singularize
  end
end
