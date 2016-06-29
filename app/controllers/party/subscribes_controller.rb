class Party::SubscribesController < Party::BaseController

  before_action :find_story, only: [:create, :destroy]

  def create
    context = StorySubscriptionCreateContext.new(@story)
    if context.perform(current_party)
      redirect_to party_stories_path, flash: { success: "案件#{@story.identity} 已訂閱" }
    else
      redirect_to party_stories_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  def destroy
    context = StorySubscriptionDeleteContext.new(@story)
    if context.perform(current_party)
      redirect_to party_stories_path, flash: { success: "案件#{@story.identity} 已取消訂閱" }
    else
      redirect_to party_stories_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
