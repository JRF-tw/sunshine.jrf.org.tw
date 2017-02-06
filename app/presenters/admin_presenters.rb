class AdminPresenters
  include ActionView::Helpers::UrlHelper

  def rater_link(score)
    score_type = score.class.name.underscore.split('_').first
    rater = score.send("#{score_type}_rater")
    wording = ApplicationController.helpers.get_name_by_role(rater) + ' - ' + rater.name
    rater_type = rater.class.name.downcase.gsub('court', '')
    path = Rails.application.routes.url_helpers.send("admin_#{rater_type}_path", rater)
    link_to wording, path
  end
end
