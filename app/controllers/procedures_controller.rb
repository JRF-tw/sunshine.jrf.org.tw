# == Schema Information
#
# Table name: procedures
#
#  id                :integer          not null, primary key
#  profile_id        :integer
#  suit_id           :integer
#  unit              :string
#  title             :string
#  procedure_unit    :string
#  procedure_content :text
#  procedure_result  :text
#  procedure_no      :string
#  procedure_date    :date
#  suit_no           :integer
#  source            :text
#  source_link       :text
#  punish_link       :string
#  file              :string
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#  is_hidden         :boolean
#

class ProceduresController < BaseController
  def index
    @suit = Suit.find(params[:suit_id])
    if @suit.is_hidden?
      not_found
    end
    @procedures_by_person = @suit.procedures_by_person
    image = @suit.pic.present? ? @suit.pic.L_540.url : nil
    set_meta(
      title: "#{@suit.title} - 處理經過",
      description: "#{@suit.title} #{@suit.summary}",
      keywords: "不適任法官案例,不適任檢察官案例,司法恐龍案例,司法案例",
      image: image
    )
  end
end
