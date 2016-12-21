class Parties::StoriesController < Parties::BaseController
  layout 'party'
  before_action :find_story, only: [:show]
  before_action :has_score?, only: [:show]

  def index
    @stories = ::PartyQueries.new(current_party).get_stories
    set_meta
  end

  def show
    @pending_score_verdict = ::PartyQueries.new(current_party).pending_score_verdict(@story)
    @pending_score_schedules = ::PartyQueries.new(current_party).pending_score_schedules(@story)
    # meta
    set_meta(
      title: { identity: @story.identity },
      description: { identity: @story.identity },
      keywords: { identity: @story.identity }
    )
  end

  private

  def find_story
    # TODO: security issue
    @story = begin
               Story.find(params[:id])
             rescue
               nil
             end
    redirect_as_fail(party_root_path, '找不到該案件') unless @story
  end

  def has_score?
    @scores_sorted = ::PartyQueries.new(current_party).get_scores_array(@story, sort_by: 'date')
    redirect_as_fail(party_root_path, '尚未有評鑑紀錄') unless @scores_sorted.present?
  end
end
