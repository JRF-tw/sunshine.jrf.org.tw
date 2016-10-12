module Search
  class StoryByCourtAndIdentityContext < BaseContext
    before_perform :find_court
    before_perform :find_story

    def initialize(court_name, year, word_type, number)
      @court_name = court_name
      @year = year
      @word_type = word_type
      @number = number
    end

    def perform
      run_callbacks :perform do
        @story
      end
    end

    private

    def find_court
      @court = Court.find_by(full_name: @court_name)
      add_error(:search_court_not_find) unless @court
    end

    def find_story
      @story = @court.stories.find_by(court: @court, year: @year, word_type: @word_type, number: @number)
    end
  end
end
