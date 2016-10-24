# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  article_type     :string
#  publish_year     :integer
#  paper_publish_at :date
#  news_publish_at  :date
#  book_title       :string
#  title            :string
#  journal_no       :string
#  journal_periods  :string
#  start_page       :integer
#  end_page         :integer
#  editor           :string
#  author           :string
#  publisher        :string
#  publish_locat    :string
#  department       :string
#  degree           :string
#  source           :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#  is_hidden        :boolean
#

class Admin::ArticlesController < Admin::BaseController
  before_action :article
  before_action { add_crumb('個人檔案列表', admin_profiles_path) }
  before_action { add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]) { add_crumb("#{@profile.name}的發表言論列表", admin_profile_articles_path(@profile)) }

  def index
    @articles = @profile.articles.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的發表言論列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@profile.name}的發表言論"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的發表言論"
    add_crumb @admin_page_title, '#'
  end

  def create
    if article.save
      respond_to do |f|
        f.html { redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@profile.name}的發表言論"
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
      redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已修改" }
    else
      @admin_page_title = "編輯#{@profile.name}的發表言論"
      add_crumb @admin_page_title, '#'
      flash[:error] = article.errors.full_messages
      render :edit
    end
  end

  def destroy
    if article.destroy
      redirect_to admin_profile_articles_path(@profile), flash: { success: "#{@profile.name}的發表言論 - 已刪除" }
    else
      flash[:error] = article.errors.full_messages
      redirect_to :back
    end
  end

  private

  def article
    @profile = Admin::Profile.find params[:profile_id]
    @article ||= params[:id] ? @profile.articles.find(params[:id]) : @profile.articles.new(article_params)
  end

  def article_params
    params.fetch(:admin_article, {}).permit(:profile_id, :article_type, :publish_year, :paper_publish_at_in_tw, :paper_publish_at, :news_publish_at_in_tw, :news_publish_at, :book_title, :title, :journal_no, :journal_periods, :start_page, :end_page, :editor, :author, :publisher, :publish_locat, :department, :degree, :source, :memo, :is_hidden)
  end
end
