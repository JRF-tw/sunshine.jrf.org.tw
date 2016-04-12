module Webmock
  def webmock_all!
    stub_request(:get, "https://google.com/api.json").
      to_return(headers: { 'Content-Type' => 'application/json' }, body: '{ "ok": true }')

    stub_request(:post, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01\.jsp/).
         with(body: { "court"=>"TPH" }).
      to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/court_info.txt"))

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A02\.jsp/).
      to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/schedule_info.txt"))

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01_DOWNLOADCVS\.jsp/).
      to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/tph_dpt.csv"))
  end
end
