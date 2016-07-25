# == Schema Information
#
# Table name: judges
#
#  id                 :integer          not null, primary key
#  name               :string
#  current_court_id   :integer
#  avatar             :string
#  gender             :string
#  gender_source      :string
#  birth_year         :integer
#  birth_year_source  :string
#  stage              :integer
#  stage_source       :string
#  appointment        :string
#  appointment_source :string
#  memo               :string
#  is_active          :boolean          default(TRUE)
#  is_hidden          :boolean          default(TRUE)
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Admin::JudgesController < Admin::BaseController
  before_action :judge
  before_action(except: [:index]) { add_crumb("法官列表", admin_judges_path) }

  def index
    @search = Judge.all.ransack(params[:q])
    @judges = @search.result.page(params[:page]).per(20)
    @admin_page_title = "法官列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "法官檔案 - #{judge.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增法官"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯法官 - #{judge.name}"
    add_crumb @admin_page_title, "#"
  end

  def create
    context = Admin::JudgeCreateContext.new(params)
    if @judge = context.perform
      redirect_as_success(admin_judges_path, "法官 - #{judge.name} 已新增")
    else
      @admin_page_title = "新增法官"
      add_crumb @admin_page_title, "#"
      render_as_fail(:new, context.error_messages)
    end
  end

  def update
    context = Admin::JudgeUpdateContext.new(@judge)
    if context.perform(params)
      redirect_as_success(admin_judges_path, "法官 - #{judge.name} 已修改")
    else
      @admin_page_title = "編輯法官 - #{judge.name}"
      add_crumb @admin_page_title, "#"
      render_as_fail(:edit, context.error_messages)
    end
  end

  def destroy
    context = Admin::JudgeDeleteContext.new(@judge)
    if context.perform
      redirect_as_success(admin_judges_path, "法官 - #{judge.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  private

  def judge
    @judge ||= params[:id] ? Admin::Judge.find(params[:id]) : Admin::Judge.new
  end
end
