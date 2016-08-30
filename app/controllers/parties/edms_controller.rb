class Parties::EdmsController < ApplicationController
  def toggle_subscribe
    # render js
    context = Party::ToggleSubscribeEdmContext.new(current_party)
    unless context.perform
      @error_messages = context.error_messages
    end
  end
end
