class Lawyer::CheckScheduleScoreInfoContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type].freeze

  before_perform :check_court_id
  before_perform :check_year
  before_perform :check_word_type
  before_perform :check_number
  before_perform :check_story_type
  before_perform :find_story
  before_perform :can_score, if: :story_has_pronounce_date?
  before_perform :story_already_adjudge

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
    return add_error(:court_not_found) unless @court
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

  def check_story_type
    return add_error(:story_type_blank) unless @params[:story_type].present?
  end

  def find_story
    return add_error(:story_not_found) unless @story = Story.where(@params).last
  end

  def story_has_pronounce_date?
    @story.pronounce_date.present?
  end

  def can_score
    return add_error(:story_already_pronounced) if Time.zone.today > @story.pronounce_date
  end

  def story_already_adjudge
    return add_error(:story_already_have_judgement) if @story.adjudge_date.present?
  end
end
