# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string
#  title      :string
#  content    :text
#  comment    :text
#  no         :string
#  source     :text
#  file       :string
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

class Admin::ReviewsController < Admin::BaseController
  before_action :review
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的相關新聞評論列表", admin_profile_reviews_path(@profile)) }

  def index
    @reviews = @profile.reviews.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的相關新聞評論列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的相關新聞評論"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的相關新聞評論"
    add_crumb @admin_page_title, "#"
  end

  def create
    if review.save
        respond_to do |f|
          f.html { redirect_to admin_profile_reviews_path(@profile), flash: { success: "#{@profile.name}的相關新聞評論 - 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@profile.name}的相關新聞評論"
          add_crumb @admin_page_title, "#"
          flash[:error] = review.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if review.update_attributes(review_params)
      redirect_to admin_profile_reviews_path(@profile), flash: { success: "#{@profile.name}的相關新聞評論 - 已修改" }
    else
      @admin_page_title = "編輯#{@profile.name}的相關新聞評論"
      add_crumb @admin_page_title, "#"
      flash[:error] = review.errors.full_messages
      render :edit
    end
  end

  def destroy
    if review.destroy
      redirect_to admin_profile_reviews_path(@profile), flash: { success: "#{@profile.name}的相關新聞評論 - 已刪除" }
    else
      flash[:error] = review.errors.full_messages
      redirect_to :back
    end
  end

  private

  def review
    @profile = Admin::Profile.find params[:profile_id]
    @review ||= params[:id] ? @profile.reviews.find(params[:id]) : @profile.reviews.new(review_params)
  end

  def review_params
    params.fetch(:admin_review, {}).permit(:profile_id, :publish_at_in_tw, :publish_at, :name, :title, :content, :comment, :no, :source, :file, :memo, :is_hidden)
  end
end
