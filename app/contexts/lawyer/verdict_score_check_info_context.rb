class Lawyer::VerdictScoreCheckInfoContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number].freeze
  SCORE_INTERVEL = 90.days

  before_perform :check_court_id
  before_perform :check_year
  before_perform :check_word_type
  before_perform :check_number
  before_perform :find_story
  before_perform :story_not_adjudge
  before_perform :valid_score_intervel
  before_perform :already_scored

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @story
    end
  end

  private

  def check_court_id
    @court = Court.find(@params[:court_id]) if @params[:court_id].present?
    return add_error(:court_not_exist) unless @court
  end

  def check_year
    return add_error(:year_blank) unless @params[:year].present?
  end

  def check_word_type
    return add_error(:word_type_blank) unless @params[:word_type].present?
  end

  def check_number
    return add_error(:number_blank) unless @params[:number].present?
  end

  def find_story
    return add_error(:story_not_exist) unless @story = Story.where(@params).last
  end

  def story_not_adjudge
    return add_error(:verdict_score_not_find) unless @story.adjudge_date.present?
  end

  def valid_score_intervel
    range = (@story.adjudge_date..@story.adjudge_date + SCORE_INTERVEL)
    return add_error(:out_score_intervel) unless range.include?(Time.zone.today)
  end

  def already_scored
    return add_error(:verdict_score_exist) if @lawyer.verdict_scores.where(story: @story).count > 0
  end
end
