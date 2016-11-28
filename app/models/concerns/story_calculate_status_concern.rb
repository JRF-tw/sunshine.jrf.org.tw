module StoryCalculateStatusConcern
  extend ActiveSupport::Concern

  included do
    include AASM
    aasm column: :calculate_status, enum: true do
      state :not_done, initial: true
      state :schedule_score_done
      state :all_score_done

      event :calculate_schedule_score do
        transitions from: :not_done, to: :schedule_score_done
      end

      event :calculate_verdict_score do
        transitions from: :schedule_score_done, to: :all_score_done
      end
    end
  end
end
