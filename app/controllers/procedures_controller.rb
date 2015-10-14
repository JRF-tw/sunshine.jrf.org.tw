class ProceduresController < BaseController
  def index
    @suit = Suit.find(params[:suit_id])
    @procedures_by_person = @suit.procedures_by_person
    image = @suit.pic.present? ? @suit.pic.L_540.url : nil
    set_meta(
      title: "#{@suit.title} - 處理經過",
      description: "#{@suit.title} #{@suit.summary}",
      keywords: "司法恐龍案例,司法案例",
      image: image
    )
  end
end
