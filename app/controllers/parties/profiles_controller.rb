class Parties::ProfilesController < Parties::BaseController
  before_action :find_party, only: [:edit, :update]

  def show
  end

  def edit
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
