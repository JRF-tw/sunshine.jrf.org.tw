class BaseContext
  extend ActiveModel::Callbacks
  define_model_callbacks :perform

  include Rails.application.routes.url_helpers
  include Errors::HandlerConcern

  SCHEDULE_SCORE_INTERVEL = 14.days
  VERDICT_SCORE_INTERVEL = 3.months

  private

  def permit_params(params, *cols)
    ActionController::Parameters.new(params).permit(cols)
  end
end
