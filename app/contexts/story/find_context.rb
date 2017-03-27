class Story::FindContext < BaseContext
  before_perform :find_court
  before_perform :find_story

  def initialize(court_code, id)
    @court_code = court_code
    @type, @year, @word, @number = id.split('-')
  end

  def perform
    run_callbacks :perform do
      return add_error(:story_not_found, '案件不存在') unless @story
      @story
    end
  end

  private

  def find_court
    @court = Court.find_by(code: @court_code)
    return add_error(:court_not_found, '該法院代號不存在') unless @court
  end

  def find_story
    @story = @court.stories.find_by(story_type: @type, year: @year, word_type: @word, number: @number, court: @court)
  end
end
