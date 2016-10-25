class Lawyers::AppealsController < Lawyers::BaseController
  skip_before_action :authenticate_lawyer!

  def new
    # meta
    set_meta(
      title: '律師人工申訴頁',
      description: '律師人工申訴頁',
      keywords: '律師人工申訴頁'
    )
  end
end
