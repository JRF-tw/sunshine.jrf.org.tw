module ApiHelper
  def response_body
    JSON.parse(response.body)
  end

  shared_context 'create_verdict_data_for_api' do
    let!(:verdict) { create :verdict, :with_file }
    let(:story) { verdict.story }
    let(:court) { verdict.story.court }
    let(:code) { court.code }
    let(:year) { story.year }
    let(:word_type) { story.word_type }
    let(:number) { story.number }
  end
end
