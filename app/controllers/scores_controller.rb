class ScoresController < BaseController
  before_action :init_meta, only: [:index]
  before_action :http_auth_for_production

  def index
  end

  private

  def init_meta
    set_meta
  end
end
