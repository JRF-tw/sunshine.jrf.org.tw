require 'rails_helper'

feature '通知' do
  feature '律師' do
    feature '未訂閱案件的判決通知' do
      Scenario '抓到判決書後，該律師已註冊、尚未訂閱該案件、且有開啟「我願意收到判決評鑑通知」時，則主動進行通知' do
        let!(:verdict) { create :verdict, :with_file }
        subject { Story::ActiveVerdictNoticeContext.new(verdict) }
        Given '律師已註冊、開啟「我願意收到判決評鑑通知」、且未訂閱該案件' do
          let!(:lawyer) { create :lawyer, :with_confirmed }
          When '判決書抓到後且抓到該律師' do
            let!(:verdict_relation) { create :verdict_relation, verdict: verdict, person: lawyer }
            Then '發送通知信' do
              expect { subject.perform }.to change_sidekiq_jobs_size_of(LawyerMailer, :active_verdict_notice)
            end
          end
        end

        Given '律師已註冊、開啟「我願意收到判決評鑑通知」、「已訂閱」該案件' do
          let!(:lawyer) { create :lawyer, :with_confirmed }
          let!(:story_subscription) { create :story_subscription, story: verdict.story, subscriber: lawyer }
          When '判決書抓到後且抓到該律師' do
            let!(:verdict_relation) { create :verdict_relation, verdict: verdict, person: lawyer }
            Then '不會發送通知信' do
              expect { subject.perform }.not_to change_sidekiq_jobs_size_of(LawyerMailer, :active_verdict_notice)
            end
          end
        end

        Given '律師已註冊、「未」開啟「我願意收到判決評鑑通知」、且未訂閱該案件' do
          let!(:lawyer) { create :lawyer, :with_confirmed, active_noticed: false }
          When '判決書抓到後且抓到該律師' do
            let!(:verdict_relation) { create :verdict_relation, verdict: verdict, person: lawyer }
            Then '不會發送通知信' do
              expect { subject.perform }.not_to change_sidekiq_jobs_size_of(LawyerMailer, :active_verdict_notice)
            end
          end
        end

        Given '律師未註冊' do
          let!(:lawyer) { create :lawyer }
          When '判決書抓到後且抓到該律師' do
            let!(:verdict_relation) { create :verdict_relation, verdict: verdict, person: lawyer }
            Then '不會發送通知信' do
              expect { subject.perform }.not_to change_sidekiq_jobs_size_of(LawyerMailer, :active_verdict_notice)
            end
          end
        end
      end
    end
  end
end
