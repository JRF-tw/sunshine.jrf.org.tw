module Scrap
  class CreateJudgeByHighestCourtContext < BaseContext
    before_perform  :is_highest_court?
    before_perform  :find_judge_by_court
    before_perform  :build_judge
    before_perform  :new_record_or_not
    after_perform :notify

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

    def notify
      SlackService.notify_create_highest_judge_alert("最高法院法官已新增 : #{@judge.name} 法官, #{SlackService.render_link("http://#{Setting.host + admin_judge_path(@judge)}", '點我查看')}") if @is_new_record
    end
  end
end
