class BulletinsController < BaseController
  before_action :init_meta, only: [:index]

  def index
    @bulletins = Bulletin.all.page(params[:page]).per(9)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    image = @bulletin.pic.present? ? @bulletin.pic.W_360.url : nil
    set_meta(
      title: { title: @bulletin.title },
      description: { title: @bulletin.title },
      keywords: { title: @bulletin.title },
      image: image
    )
  end
end
