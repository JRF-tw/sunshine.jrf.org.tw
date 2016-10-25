class CourtObservers::ProfilesController < CourtObservers::BaseController
  before_action :find_court_observer, only: [:edit, :update]

  def show
    # meta
    set_meta(
      title: '觀察者個人資訊頁',
      description: '觀察者個人資訊頁',
      keywords: '觀察者個人資訊頁'
    )
  end

  def edit
    # meta
    set_meta(
      title: '觀察者編輯個人資訊頁',
      description: '觀察者編輯個人資訊頁',
      keywords: '觀察者編輯個人資訊頁'
    )
  end

  def update
    context = CourtObserver::UpdateProfileContext.new(@court_observer)
    if context.perform(params[:court_observer])
      redirect_to court_observer_profile_path, flash: { success: '個人資訊已修改' }
    else
      flash.now[:error] = context.error_messages.join(', ')
      render :edit
    end
  end

  def find_court_observer
    @court_observer || @court_observer = CourtObserver.find(current_court_observer.id)
  end
end
