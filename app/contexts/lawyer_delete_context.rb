class LawyerDeleteContext < BaseContext
  before_perform :check_story_empty

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.destroy
    end
  end

  def check_story_empty
    return add_error(:data_delete_fail) if @lawyer.stories.present?
    true
  end
end