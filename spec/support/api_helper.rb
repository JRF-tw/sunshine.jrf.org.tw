module ApiHelper
  def response_body
    JSON.parse(response.body)
  end

  shared_context 'create_data_for_api' do
    let(:story) { create :story }
    let(:court) { story.court }
    let(:code) { court.code }
  end
end
