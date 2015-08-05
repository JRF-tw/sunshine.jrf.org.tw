class Admin::ArticlesController < Admin::BaseController
  before_action :article
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的發表言論列表", admin_profile_articles_path(@profile)) }

  def index
    @articles = @profile.articles.all.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的發表言論列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的發表言論"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的發表言論"
    add_crumb @admin_page_title, "#"
  end

  def create
    if article.save
        respond_to do |f|
          f.html { redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html { render :new, flash: { error: article.errors.full_messages } }
        f.js { render }
      end
    end
  end

  def update
    if article.update_attributes(article_params)
      redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已修改" }
    else
      render :edit, flash: { error: article.errors.full_messages }
    end
  end

  def destroy
    if article.destroy
      redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已刪除" }
    else
      redirect_to :back, flash: { error: article.errors.full_messages }
    end
  end

  private

  def article
    @profile = Admin::Profile.find params[:profile_id]
    @article ||= params[:id] ? @profile.articles.find(params[:id]) : @profile.articles.new(article_params)
  end

  def article_params
    params.fetch(:admin_article, {}).permit(:profile_id, :article_type, :publish_year, :paper_publish_at, :news_publish_at, :book_title, :title, :journal_no, :journal_periods, :start_page, :end_page, :editor, :author, :publisher, :publish_locat, :department, :degree, :source, :memo)
  end
end