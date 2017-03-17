class Api::StorySearchContext < BaseContext
  before_perform :set_ransack_query
  before_perform :find_court, if: :court_code_exist?
  before_perform :check_query_exist
  before_perform :search_story

  def initialize(params)
    @year = params[:year]
    @word = params[:word]
    @number = params[:number]
    @court_code = params[:court_code]
    @story_type = params[:story_type]
    @lawyer_words = params[:lawyer_names_cont]
    @judge_words = params[:judge_names_cont]
    @start_time = params[:adjudge_date_gteq]
    @end_time = params[:adjudge_date_lteq]
  end

  def perform
    run_callbacks :perform do
      return add_error(:story_not_found, '查無案件') unless @stories.present?
      @stories
    end
  end

  private

  def set_ransack_query
    @ransack_query = {
      year_eq: @year,
      word_type_eq: @word,
      number_eq: @number,
      story_type_eq: @story_type,
      lawyer_names_cont: @lawyer_words,
      judges_names_cont: @judge_words,
      adjudge_date_gteq: @start_time,
      adjudge_date_lteq: @end_time
    }
  end

  def find_court
    @court = Court.find_by(code: @court_code)
    return add_error(:court_not_found, '法院代號不存在') unless @court
    @ransack_query.merge!(court_id_eq: @court.id)
  end

  def court_code_exist?
    @court_code
  end

  def check_query_exist
    return add_error(:params_not_exist) unless @ransack_query.values.any?
  end

  def search_story
    @stories = Story.newest.ransack(@ransack_query).result.includes(:court)
  end
end
