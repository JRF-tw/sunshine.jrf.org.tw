class Party::BaseController < ApplicationController
  layout 'party'
  before_action :authenticate_party!
  before_action :set_phone?

  private

  def set_phone?
    redirect_to new_party_phone_path unless current_party.phone_number.present?
  end

end
