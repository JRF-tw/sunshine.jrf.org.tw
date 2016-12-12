class Admin::ProsecutorDeleteContext < BaseContext
  after_perform :update_judge_status

  def initialize(prosecutor)
    @prosecutor = prosecutor
  end

  def perform
    run_callbacks :perform do
      @prosecutor.destroy
    end
  end

  private

  def update_judge_status
    @prosecutor.judge.update_attributes(is_prosecutor: false) if @prosecutor.judge
  end

end
