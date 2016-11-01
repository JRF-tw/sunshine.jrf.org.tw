require 'rails_helper'

describe '律師案件通知', type: :request do
  context '可訂閱與否' do
    let(:story) { create(:story) }
    let(:context) { Lawyer::StorySubscriptionToggleContext.new(story) }

    context 'Given 有設定密碼 (即已註冊)' do
      let!(:lawyer) { create(:lawyer, :with_password, :with_confirmed) }

      context 'When 訂閱案件' do
        subject { context.perform(lawyer) }

        it 'Then 訂閱成功' do
          expect { subject }.to change { StorySubscription.count }.by(1)
        end
      end
    end

    context 'Given 尚未註冊' do
      let!(:lawyer) { create(:lawyer, :with_password) }

      context 'When 訂閱案件' do
        subject { context.perform(lawyer) }

        it 'Then 訂閱失敗' do
          expect { subject }.not_to change { StorySubscription.count }
        end
      end
    end
  end

  context '已訂閱的案件' do
    let!(:lawyer) { lawyer_subscribe_story_date_today }

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
    let!(:lawyer) { lawyer_subscribe_story_date_today }
    let(:params) { { token: Digest::MD5.hexdigest(lawyer.email + 'P2NVel3pHp') } }
    context '案件已訂閱' do
      before { StorySubscriptionDeleteContext.new(Story.last).perform(lawyer, params) }

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
      let!(:lawyer) { create(:lawyer, :with_confirmed, :with_password) }
      let!(:story) { create(:story, :with_schedule_date_today) }
      let(:params) { { token: Digest::MD5.hexdigest(lawyer.email + 'P2NVel3pHp') } }
      subject { StorySubscriptionDeleteContext.new(story).perform(lawyer, params) }

      it '不變' do
        expect { subject }.not_to change { StorySubscription.count }
      end
    end
  end

end
