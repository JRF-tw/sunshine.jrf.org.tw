require 'rails_helper'

describe '判決書分析', type: :context do
  subject { Scrap::ScheduleScoreConvertContext }
  feature '評鑑有效無效處理' do
    let!(:story) { create :story, :pronounced }
    let!(:judge_A) { create :judge }
    let!(:judge_B) { create :judge }

    Scenario '觀察者的開庭評鑑是否有效，取決於法官是否有抓到' do
      let!(:court_observer) { create :court_observer }

      Given '觀察者在同案件下，對法官A和法官B有開庭評鑑記錄' do
        let!(:schedule_score_A) { create :schedule_score, story: story, schedule_rater: court_observer, judge: judge_A }
        let!(:schedule_score_B) { create :schedule_score, story: story, schedule_rater: court_observer, judge: judge_B }
        let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name] }
        When '判決書上有法官A、無法官B' do
          Then '法官A評鑑有效、法官B評鑑無效' do
            expect(subject.new(schedule_score_A).perform).to be_truthy
            expect(subject.new(schedule_score_B).perform).to be_falsey
          end
        end
      end
    end

    Scenario '律師的開庭評鑑是否有效，取決於法官和律師是否都有抓到' do
      let!(:lawyer) { create :lawyer, :with_confirmed }
      Given '律師在同案件下，對法官A和法官B有開庭評鑑記錄，且判決書上有法官A、無法官B' do
        let!(:schedule_score_A) { create :schedule_score, story: story, schedule_rater: lawyer, judge: judge_A }
        let!(:schedule_score_B) { create :schedule_score, story: story, schedule_rater: lawyer, judge: judge_B }
        let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name], lawyer_names: [lawyer.name] }
        When '有抓到律師姓名' do
          Then '法官A評鑑有效、法官B評鑑無效' do
            expect(subject.new(schedule_score_A).perform).to be_truthy
            expect(subject.new(schedule_score_B).perform).to be_falsey
          end
        end

        When '沒抓到律師姓名' do
          let!(:verdict) { create :verdict, is_judgment: true, story: story, judges_names: [judge_A.name] }
          Then '評鑑皆無效' do
            expect(subject.new(schedule_score_A).perform).to be_falsey
            expect(subject.new(schedule_score_B).perform).to be_falsey
          end
        end
      end
    end

    Scenario '當事人的開庭評鑑是否有效，取決於法官和當事人是否都有抓到' do
      let!(:party) { create :party, :already_confirmed}
      Given '當事人在同案件下，對法官A和法官B有開庭評鑑記錄，且判決書上有法官A、無法官B' do
        let!(:schedule_score_A) { create :schedule_score, story: story, schedule_rater: party, judge: judge_A }
        let!(:schedule_score_B) { create :schedule_score, story: story, schedule_rater: party, judge: judge_B }
        let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name], party_names: [party.name] }
        When '有抓到當事人姓名' do
          Then '法官A開庭評鑑有效、法官B開庭評鑑無效' do
            expect(subject.new(schedule_score_A).perform).to be_truthy
            expect(subject.new(schedule_score_B).perform).to be_falsey
          end
        end

        When '沒抓到當事人姓名' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name] }
          Then '開庭評鑑皆無效' do
            expect(subject.new(schedule_score_A).perform).to be_falsey
            expect(subject.new(schedule_score_B).perform).to be_falsey
          end
        end
      end
    end

    Scenario '抓到判決書後，才能進行判決評鑑' do
      subject { Scrap::VerdictScoreConvertContext }
      Scenario '當事人的判決評鑑是否有效，取決於當事人和法官姓名是否有抓到' do
        let!(:party) { create :party, :already_confirmed}
        Given '判決書有當事人姓名、有法官A,B姓名' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name], party_names: [party.name] }
          When '當事人進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: party }
            Then '當事人對法官A,B 共 2 筆判決評鑑皆有效' do
              expect { subject.new(verdict_score).perform }.to change { ValidScore.count }.by(2)
            end
          end
        end

        Given '判決書無當事人姓名、有法官A,B姓名' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name] }
          When '當事人進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: party }
            Then '當事人的判決評鑑皆無效' do
              expect { subject.new(verdict_score).perform }.not_to change { ValidScore.count }
            end
          end
        end

        Given '判決書有當事人姓名、無法官' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, party_names: [party.name] }
          When '當事人進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: party }
            Then '當事人的判決評鑑皆無效' do
              expect { subject.new(verdict_score).perform }.not_to change { ValidScore.count }
            end
          end
        end
      end

      Scenario '律師的判決評鑑是否有效，取決於律師和法官姓名是否有抓到' do
        let!(:lawyer) { create :lawyer, :with_confirmed }
        Given '判決書有律師姓名、有法官A,B姓名' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name], lawyer_names: [lawyer.name] }
          When '律師進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: lawyer }
            Then '律師對法官A,B 共 2 筆判決評鑑皆有效' do
              expect { subject.new(verdict_score).perform }.to change { ValidScore.count }.by(2)
            end
          end
        end

        Given '判決書無律師姓名、有法官A,B姓名' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name] }
          When '律師進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: lawyer }
            Then '律師的判決評鑑皆無效' do
              expect { subject.new(verdict_score).perform }.not_to change { ValidScore.count }
            end
          end
        end

        Given '判決書有律師姓名、無法官' do
          let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, lawyer_names: [lawyer.name] }
          When '律師進行判決評鑑（一次）' do
            let!(:verdict_score) { create :verdict_score, story: story , verdict_rater: lawyer }
            Then '律師的判決評鑑皆無效' do
              expect { subject.new(verdict_score).perform }.not_to change { ValidScore.count }
            end
          end
        end
      end
    end
  end
end
