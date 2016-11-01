class Parties::SubscribesController < Parties::BaseController
  before_action :find_story, only: [:toggle, :destroy]

  def toggle
    Party::StorySubscriptionToggleContext.new(@story).perform(current_party)
  end

  def destroy
    context = StorySubscriptionDeleteContext.new(@story)
    if context.perform(current_party, params)
      redirect_to party_root_path, flash: { success: "案件#{@story.identity} 已取消訂閱" }
    else
      redirect_to party_root_path, flash: { error: context.error_messages.join(', ').to_s }
    end
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
