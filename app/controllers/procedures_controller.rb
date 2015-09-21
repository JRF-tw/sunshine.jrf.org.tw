class ProceduresController < BaseController
  def index
    @suit = Suit.find(params[:suit_id])
    @procedures_by_person = @suit.procedures_by_person
    set_meta(title: "案例內容 - 案例處理經過")
  end
end
