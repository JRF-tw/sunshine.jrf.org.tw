class Parties::ProfilesController < Parties::BaseController
  before_action :find_party, only: [:edit, :update]
  before_action :init_meta, only: [:show, :edit]

  def show
  end

  def edit
  end

  def update
    context = Party::UpdateProfileContext.new(@party)
    if context.perform(params[:party])
      redirect_to party_profile_path, flash: { success: '個人資訊已修改' }
    else
      flash.now[:notice] = context.error_messages.join(', ')
      render :edit
    end
  end

  private

  def find_party
    @party || @party = Party.find(current_party.id)
  end

  def init_meta
    set_meta
  end
end
