class Admin::ScorePresenters
  include ActionView::Helpers::UrlHelper

  def rater_link(score)
    score_type = score.class.name.underscore.split('_').first
    rater = score.send("#{score_type}_rater")
    wording = rater.model_name.human + ' - ' + rater.name
    rater_type = rater.class.name.downcase.gsub('court', '')
    path = Rails.application.routes.url_helpers.send("admin_#{rater_type}_path", rater)
    link_to wording, path
  end
end
