class Lawyers::SubscribesController < Lawyers::BaseController
  before_action :find_story, only: [:destroy, :toggle]

  def toggle
    Lawyer::StorySubscriptionToggleContext.new(@story).perform(current_lawyer)
  end

  def destroy
    context = Lawyer::StorySubscriptionDeleteContext.new(@story)
    if context.perform(current_lawyer)
      redirect_to lawyer_root_path, flash: { success: "案件#{@story.identity} 已取消訂閱" }
    else
      redirect_to lawyer_root_path, flash: { error: context.error_messages.join(", ").to_s }
    end
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
