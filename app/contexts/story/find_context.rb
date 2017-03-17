class Story::FindContext < BaseContext
  before_perform :find_court
  before_perform :find_story

  def initialize(params)
    @year, @word, @number = params[:id].split('-')
    @court_code = params[:court_code]
  end

  def perform
    run_callbacks :perform do
      return add_error(:story_not_found, '查無案件') unless @story.present?
      @story
    end
  end

  private

  def find_court
    @court = Court.find_by(code: @court_code)
    return add_error(:court_not_found, '法院代號不存在') unless @court
  end

  def find_story
    @story = Story.find_by(year: @year, word_type: @word, number: @number, court: @court)
  end
end
