class Api::StoriesSearchContext < BaseContext
  before_perform :check_query_exist
  before_perform :set_ransack_query
  before_perform :find_court, if: :court_code_exist?
  before_perform :search_story

  def initialize(params)
    @params = params
  end

  def perform
    run_callbacks :perform do
      @stories
    end
  end

  private

  def check_query_exist
    return add_error(:params_not_exist) unless @params
  end

  def set_ransack_query
    @ransack_query = {
      year_eq: @params[:year],
      word_type_eq: @params[:word],
      number_eq: @params[:number],
      story_type_eq: @params[:story_type],
      lawyer_names_cont: @params[:lawyer_names_cont],
      judges_names_cont: @params[:judge_names_cont],
      adjudge_date_gteq: @params[:adjudge_date_gteq],
      adjudge_date_lteq: @params[:adjudge_date_lteq]
    }
  end

  def find_court
    @court = Court.find_by(code: @params[:court_code])
    return add_error(:court_not_found, '該法院代號不存在') unless @court
    @ransack_query.merge!(court_id_eq: @court.id)
  end

  def court_code_exist?
    @params[:court_code]
  end

  def search_story
    @stories = Story.newest.ransack(@ransack_query).result.includes(:court)
  end
end
