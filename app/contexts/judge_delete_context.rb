class JudgeDeleteContext < BaseContext

  def initialize(judge)
    @judge = judge
  end

  def perform
    run_callbacks :perform do
      @judge.destroy
    end
  end

end