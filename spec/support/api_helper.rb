module ApiHelper
  def response_body
    JSON.parse(response.body)
  end

  def court_body(court)
    {
      name: court.full_name,
      simple_name: court.name,
      code: story.court.code
    }
  end

  shared_context 'create_data_for_request' do
    let(:story) { create :story }
    let(:court) { story.court }
    let(:code) { court.code }
  end
end
