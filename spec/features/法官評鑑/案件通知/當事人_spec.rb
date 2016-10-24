require 'rails_helper'

describe '當事人案件通知', type: :request do
  context '可訂閱與否' do
    let(:story) { create(:story) }
    let(:context) { Party::StorySubscriptionToggleContext.new(story) }

    context '有通過email驗證' do
      let!(:party) { create(:party, :already_confirmed) }

      it '可以訂閱' do
        expect { context.perform(party) }.to change { StorySubscription.count }.by(1)
      end
    end

    context '沒有通過驗證的email 但有正在驗證中的email' do
      let!(:party) { create(:party, :with_unconfirmed_email) }

      it '不可訂閱' do
        expect { context.perform(party) }.not_to change { StorySubscription.count }
      end
    end

    context '沒有通過驗證的email 也沒有正在驗證中的email' do
      let!(:party) { create(:party) }

      it '不可訂閱' do
        expect { context.perform(party) }.not_to change { StorySubscription.count }
      end
    end
  end

  context '已訂閱的案件' do
    let!(:party) { party_subscribe_story_date_today }

    context '開庭前「一天」會進行 email 開庭通知' do
      before { Timecop.freeze(Time.zone.today - 1) }
      after { Timecop.return }
      subject { Crontab::SubscribeStoryBeforeJudgeNotifyContext.new(Time.zone.today).perform }

      it '寄出email' do
        expect { subject }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer)
      end
    end

    context '開庭後「隔天」會進行 email 通知評鑑' do
      before { Timecop.freeze(Time.zone.today + 1) }
      after { Timecop.return }
      subject { Crontab::SubscribeStoryAfterJudgeNotifyContext.new(Time.zone.today).perform }

      it '寄出email' do
        expect { subject }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer)
      end
    end
  end

  context '取消訂閱' do
    let!(:party) { party_subscribe_story_date_today }
    context '案件已訂閱' do
      before { StorySubscriptionDeleteContext.new(Story.last).perform(party) }

      it '成功取消' do
        expect(StorySubscription.count).to eq(0)
      end

      context '開庭前「1 天」不會進行 email 開庭通知' do
        before { Timecop.freeze(Time.zone.today - 1) }
        after { Timecop.return }
        subject { Crontab::SubscribeStoryBeforeJudgeNotifyContext.new(Time.zone.today).perform }

        it '不會寄出email' do
          expect { subject }.not_to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer)
        end
      end

      context '開庭後「隔天」不會進行 email 通知評鑑' do
        before { Timecop.freeze(Time.zone.today + 1) }
        after { Timecop.return }
        subject { Crontab::SubscribeStoryAfterJudgeNotifyContext.new(Time.zone.today).perform }

        it '不會寄出email' do
          expect { subject }.not_to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer)
        end
      end
    end

    context '案件未訂閱' do
      let!(:party) { create(:party, :already_confirmed) }
      let!(:story) { create(:story, :with_schedule_date_today) }
      subject { StorySubscriptionDeleteContext.new(story).perform(party) }

      it '不變' do
        expect { subject }.not_to change { StorySubscription.count }
      end
    end
  end

end
