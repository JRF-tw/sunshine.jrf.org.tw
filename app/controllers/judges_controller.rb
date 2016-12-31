class JudgesController < BaseController
  def show
    @judge = Judge.find(params[:id])
    set_meta(
      title: { name: @judge.name },
      description: { name: @judge.name },
      keywords: { name: @judge.name }
    )
  end
end
