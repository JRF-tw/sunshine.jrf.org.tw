class ProceduresController < BaseController
  def index
    @suit = Suit.find(params[:suit_id])
    if @suit.is_hidden?
      not_found
    end
    @procedures_by_person = @suit.procedures_by_person
    image = @suit.pic.present? ? @suit.pic.L_540.url : nil
    init_meta(
      title: { title: @suit.title },
      description: { title: @suit.title, summary: @suit.summary },
      image: image
    )
  end
end
