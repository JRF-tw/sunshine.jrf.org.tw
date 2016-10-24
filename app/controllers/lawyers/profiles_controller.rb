class Lawyers::ProfilesController < Lawyers::BaseController
  layout 'lawyer'
  before_action :find_lawyer, only: [:edit, :update]
  # TODO: Layout render error

  def show
    # meta
    set_meta(
      title: '律師個人資訊頁',
      description: '律師個人資訊頁',
      keywords: '律師個人資訊頁'
    )
  end

  def edit
    # meta
    set_meta(
      title: '律師個人資訊編輯頁',
      description: '律師個人資訊編輯頁',
      keywords: '律師個人資訊編輯頁'
    )
  end

  def update
    context = Lawyer::UpdateProfileContext.new(@lawyer)
    if context.perform(params[:lawyer])
      redirect_to lawyer_profile_path, flash: { success: '個人資訊已修改' }
    else
      flash.now[:error] = context.error_messages.join(', ')
      render :edit
    end
  end

  def find_lawyer
    @lawyer || @lawyer = Lawyer.find(current_lawyer.id)
  end
end
