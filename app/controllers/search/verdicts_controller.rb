class Search::VerdictsController < BaseController
  def show
    @court_code = params[:court_code]
    @id = params[:id]
    # TODO : pass verdict API url to view
  end
end
