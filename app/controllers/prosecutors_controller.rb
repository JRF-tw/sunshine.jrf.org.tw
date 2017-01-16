class ProsecutorsController < BaseController
  before_action :http_auth_for_production

  def show
    @prosecutor = Prosecutor.find(params[:id])
    set_meta(
      title: { name: @prosecutor.name },
      description: { name: @prosecutor.name },
      keywords: { name: @prosecutor.name }
    )
  end
end
