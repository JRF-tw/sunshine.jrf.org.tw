class Lawyers::SubscribesController < Lawyers::BaseController

  before_action :find_story, only: [:create, :destroy]

  def create
    context = Lawyer::StorySubscriptionCreateContext.new(@story)
    if context.perform(current_lawyer)
      redirect_to lawyer_root_path, flash: { success: "案件#{@story.identity} 已訂閱" }
    else
      redirect_to lawyer_root_path, flash: { error: context.error_messages.join(", ").to_s }
    end
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
