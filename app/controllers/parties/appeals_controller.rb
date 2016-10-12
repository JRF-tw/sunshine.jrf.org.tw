class Parties::AppealsController < Parties::BaseController
  def new
    # meta
    set_meta(
      title: "當事人人工申訴頁",
      description: "當事人人工申訴頁",
      keywords: "當事人人工申訴頁"
    )
  end
end
