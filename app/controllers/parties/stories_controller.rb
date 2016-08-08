class Parties::StoriesController < Parties::BaseController
  layout "party"
  before_action :find_story, only: [:show]
  before_action :has_score?, only: [:show]

  def index
    @stories = ::PartyQueries.new(current_party).get_stories
  end

  def show
    @pending_score_verdict = ::PartyQueries.new(current_party).pending_score_verdict(@story)
    @pending_score_schedules = ::PartyQueries.new(current_party).pending_score_schedules(@story)
  end

  private

  def find_story
    # TODO: security issue
    @story = Story.find(params[:id]) rescue nil
    redirect_as_fail(party_stories_path, "找不到該案件") unless @story
  end

  def has_score?
    @verdict_score = ::PartyQueries.new(current_party).get_verdict_score(@story)
    @schedule_score = ::PartyQueries.new(current_party).get_schedule_score(@story)
    redirect_as_fail(party_stories_path, "尚未有評鑑紀錄") unless @verdict_score.present? || @schedule_score.present?
  end
end
