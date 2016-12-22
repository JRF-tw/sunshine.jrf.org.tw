class Lawyers::ProfilesController < Lawyers::BaseController
  layout 'lawyer'
  before_action :find_lawyer, only: [:edit, :update]
  before_action :init_meta, only: [:show, :edit]

  # TODO: Layout render error
  def show
  end

  def edit
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

  private

  def find_lawyer
    @lawyer || @lawyer = Lawyer.find(current_lawyer.id)
  end

  def init_meta
    set_meta
  end
end
