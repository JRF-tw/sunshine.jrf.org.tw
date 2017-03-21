class Api::VerdictSearchContext < BaseContext
  before_perform :find_court
  before_perform :find_story

  def initialize(params)
    @court_code = params[:court_code]
    @story_type, @year, @word, @number = params[:id].split('-')
  end

  def perform
    run_callbacks :perform do
      return add_error(:verdicts_not_exist) unless @story.verdict
      @story.verdict
    end
  end

  private

  def find_court
    @court = Court.find_by(code: @court_code)
    return add_error(:court_not_found, '該法院代號不存在') unless @court
  end

  def find_story
    @story = Story.find_by(story_type: @story_type, year: @year, word_type: @word, number: @number, court: @court)
    return add_error(:story_not_found) unless @story
  end

end
