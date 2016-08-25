class Lawyers::EdmsController < Lawyers::BaseController
  def toggle_subscribe
    # render js
    context = Lawyer::ToggleSubscribeEdmContext.new(current_lawyer)
    unless context.perform
      @error_messages = context.error_messages
    end
  end
end
