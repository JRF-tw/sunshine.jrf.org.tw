class Parties::ProfilesController < Parties::BaseController
  before_action :find_party, only: [:edit, :update]

  def show
    # meta
    set_meta(
      title: "當事人個人資訊頁",
      description: "當事人個人資訊頁",
      keywords: "當事人個人資訊頁"
    )
  end

  def edit
    # meta
    set_meta(
      title: "當事人個人資訊編輯頁",
      description: "當事人個人資訊編輯頁",
      keywords: "當事人個人資訊編輯頁"
    )
  end

  def update
    context = Party::UpdateProfileContext.new(@party)
    if context.perform(params[:party])
      redirect_to party_profile_path, flash: { success: "個人資訊已修改" }
    else
      redirect_to :back, flash: { notice: context.error_messages.join(", ") }
    end
  end

  def find_party
    @party || @party = Party.find(current_party.id)
  end
end
