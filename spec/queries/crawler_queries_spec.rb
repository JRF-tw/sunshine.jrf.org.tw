require 'rails_helper'

RSpec.describe CrawlerQueries do
  subject { described_class }

  describe '.by_story' do
    let!(:story) { create :story }
    let!(:court) { story.court }
    it {
      expect(subject.by_story(story)).to eq(
        "?v_court=#{court.code + ' ' + court.scrap_name}&v_sys=#{story.type_for_crawler}&jud_year=#{story.year}&jud_case=#{story.word_type}&jud_no=#{story.number}&jud_no_end=&jud_title=&keyword=&sdate=&edate=&page=1"
      )
    }
  end

  describe '#index_url' do
    let(:params) { attributes_for(:crawler_queries_for_params) }
    it {
      expect(subject.new(params).index_url).to eq(
        "?v_court=#{params[:court].code + ' ' + params[:court].scrap_name}&v_sys=#{params[:type]}&jud_year=#{params[:year]}&jud_case=#{params[:word]}&jud_no=#{params[:number]}&jud_no_end=&jud_title=&keyword=&sdate=#{params[:start_date]}&edate=#{params[:end_date]}&page=1"
      )
    }
  end

  describe '#show_url' do
    let(:params) { attributes_for(:crawler_queries_for_params) }
    it {
      expect(subject.new(params).show_url).to eq(
        "?id=#{params[:scrap_id]}&v_court=#{params[:court].code + ' ' + params[:court].scrap_name}&v_sys=#{params[:type]}&jud_year=#{params[:year]}&jud_case=#{params[:word]}&jud_no=#{params[:number]}&jud_no_end=&jud_title=&keyword=&sdate=#{params[:start_date]}&edate=#{params[:end_date]}&page=1&searchkw=&jmain=&cw=0"
      )
    }
  end
end
