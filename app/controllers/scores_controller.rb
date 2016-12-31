class ScoresController < BaseController
  before_action :init_meta, only: [:index]

  def index
  end

  private

  def init_meta
    set_meta
  end
end
