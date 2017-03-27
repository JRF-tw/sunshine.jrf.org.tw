class Search::VerdictsController < BaseController
  before_action :http_auth_for_production

  def show
    @court_code = params[:court_code]
    @id = params[:id]
    # TODO : pass verdict API url to view
  end
end
