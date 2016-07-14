class Lawyers::ScoresController < Lawyers::BaseController
  def index
    @schedule_scores = current_lawyer.schedule_scores
  end

  def show
  end

  def edit
  end

  def chose_type
  end
end
