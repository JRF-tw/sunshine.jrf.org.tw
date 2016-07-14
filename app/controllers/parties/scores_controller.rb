class Parties::ScoresController < Parties::BaseController
  def index
    @schedule_scores = current_party.schedule_scores
  end

  def show
  end

  def edit
  end

  def chose_type
  end
end
