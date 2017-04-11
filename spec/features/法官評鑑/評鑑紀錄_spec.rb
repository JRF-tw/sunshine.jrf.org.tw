require 'rails_helper'

describe '法官評鑑 - 評鑑紀錄', type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:judge) { create :judge, court: court }
  let!(:story) { create :story, :adjudged }
  let!(:verdict) { create :verdict, story: story }

  before { signin_lawyer(lawyer) }

  context 'Given 有評鑑資料' do
    let!(:schedule_score) { create :schedule_score, :with_start_on, schedule_rater: lawyer, judge: judge, story: story }
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story }

    context 'When 到個人評鑑記錄頁' do
      subject! { get '/lawyer' }

      it 'Then 頁面成功讀取' do
        expect(response).to be_success
      end
    end

    context 'When 到該案件評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 頁面成功讀取' do
        expect(response).to be_success
      end
    end
  end

  context 'Given 無評鑑資料' do
    context 'When 到個人評鑑記錄頁' do
      subject! { get '/lawyer' }

      it 'Then 頁面成功讀取' do
        expect(response).to be_success
      end
    end

    context 'When 到任一案件評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 轉跳回個人評鑑記錄頁' do
        expect(response).to be_redirect
      end
    end
  end

  context 'Given 案件已宣判，且尚未評鑑判決，且有開庭評鑑記錄' do
    let!(:schedule_score) { create :schedule_score, :with_start_on, schedule_rater: lawyer, judge: judge, story: story }
    before { story.update_attributes(adjudge_date: Time.zone.today, is_adjudge: true) }

    context 'When 到該案件的評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 「待評鑑」區塊內不會出現庭期表的新增項目' do
        expect(response.body).not_to match('新增開庭評鑑')
      end

      it 'Then 「待評鑑」區塊內出現新增判決評鑑的新增項目' do
        expect(response.body).to match('新增判決評鑑')
      end

      it 'Then 已評鑑的開庭評鑑，會出現在「已評鑑」區塊內' do
        expect(response.body).to match('編輯評鑑')
      end
    end
  end

  context 'Given 案件已宣判，且已評鑑判決' do
    let!(:verdict) { create :verdict, story: story }
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story }
    before { story.update_attributes(adjudge_date: Time.zone.today, is_adjudge: true) }

    context 'When 到該案件的評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 「已評鑑」區塊內出現判決評鑑的編輯項目' do
        expect(response.body).to match('編輯評鑑')
      end

      it 'Then 「待評鑑」區塊內不會出現判決評鑑的新增' do
        expect(response.body).not_to match('新增判決評鑑')
      end
    end
  end

  context 'Given 案件已宣判，且已評鑑判決，但已超過判決評鑑時間' do
    let!(:verdict) { create :verdict, story: story }
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story }
    before { story.verdict.update_attributes(created_at: Time.zone.today - 91.days) }
    context 'When 到該案件的評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 「已評鑑」區塊內出現判決評鑑的編輯項目（進去到編輯頁後才會 redirect ，已測試）' do
        expect(response.body).to match('編輯評鑑')
      end
    end
  end

  context 'Given 案件未宣判，已有開庭評鑑記錄' do
    let!(:schedule1) { create :schedule, :date_is_yesterday, court: court, story: story }
    let!(:schedule_score) { create :schedule_score, :with_start_on, schedule_rater: lawyer, judge: judge, story: story }
    before { story.update_attributes(adjudge_date: nil, is_adjudge: false) }

    context 'When 到該案件的評鑑記錄頁' do
      subject! { get "/lawyer/stories/#{story.id}" }

      it 'Then 庭期表依日期的每一次開庭新增項目都會出現在「待評鑑」' do
        expect(response.body).to match('新增開庭評鑑')
        expect(response.body).to match(schedule1.start_on.to_s)
      end

      it 'Then 開庭評鑑記錄，會出現在「已評鑑」區塊內' do
        expect(response.body).to match('編輯評鑑')
      end
    end
  end
end
