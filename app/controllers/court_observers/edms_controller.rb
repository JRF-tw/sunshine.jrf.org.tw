class CourtObservers::EdmsController < ApplicationController
  def toggle_subscribe
    # render js
    context = CourtObserver::ToggleSubscribeEdmContext.new(current_court_observer)
    unless context.perform
      @error_messages = context.error_messages
    end
  end
end
