class Observers::ScoresController < Observers::BaseController
  def index
    @schedule_scores = current_court_observer.schedule_scores
  end

  def show
  end

  def edit
  end

  def chose_type
  end
end
