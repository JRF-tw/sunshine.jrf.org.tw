module Scrap
  class CreateJudgeByHighestCourtContext < BaseContext
    before_perform  :is_highest_court?
    before_perform  :find_judge_by_court
    before_perform  :build_judge
    before_perform  :new_record_or_not
    after_perform   :assign_to_redis

    def initialize(court, name)
      @court = court
      @name = name
    end

    def perform
      run_callbacks :perform do
        return add_error(:scrap_judge_create_fail) unless @judge.save
        @judge
      end
    end

    private

    def is_highest_court?
      return add_error(:scrap_not_highest_court) unless @court.code == 'TPS'
    end

    def find_judge_by_court
      @judge = @court.judges.find_by(name: @name)
    end

    def build_judge
      @judge = @court.judges.new(name: @name) unless @judge
    end

    def new_record_or_not
      @is_new_record = @judge.new_record?
    end

    def assign_to_redis
      hash = Redis::HashKey.new('higest_court_judge_created')
      hash[@judge.name] = Time.zone.today.to_s
    end
  end
end
