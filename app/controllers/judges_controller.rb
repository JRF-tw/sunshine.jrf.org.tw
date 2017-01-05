class JudgesController < BaseController
  before_action :http_auth_for_production

  def show
    @judge = Judge.find(params[:id])
    set_meta(
      title: { name: @judge.name },
      description: { name: @judge.name },
      keywords: { name: @judge.name }
    )
  end
end
