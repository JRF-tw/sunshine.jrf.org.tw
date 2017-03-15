class Api::StorySearchContext < BaseContext
  before_perform :find_court
  before_perform :search_story

  def initialize(search_params)
    @year, @word, @number = search_params[:id].split('-')
    @court_code = search_params[:court_code]
    @lawyer_words = search_params[:lawyer_names_cont]
    @judge_words = search_params[:judge_names_cont]
    @start_time = search_params[:adjudge_date_gteq]
    @end_time = search_params[:adjudge_date_lteq]
  end

  def perform
    run_callbacks :perform do
      return add_error(:story_not_found, '查無案件') unless @stories.present?
      @stories
    end
  end

  private

  def find_court
    @court = Court.find_by(code: @court_code)
    return add_error(:court_not_found, '法院代號不存在') unless @court
  end

  def search_story
    @stories = Story.includes(:court).where(court: @court).newest.ransack(ransack_query).result
  end

  def ransack_query
    { 
      year_eq: @year,
      word_type_eq: @word,
      number_eq: @number,
      lawyer_names_cont: @lawyer_words, 
      judges_names_cont: @judge_words, 
      adjudge_date_gteq: @start_time, 
      adjudge_date_lteq: @end_time
    }
  end
end
