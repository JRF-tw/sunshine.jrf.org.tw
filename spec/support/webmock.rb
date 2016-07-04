module Webmock
  def webmock_all!
    stub_request(:get, "https://google.com/api.json")
      .to_return(headers: { "Content-Type" => "application/json" }, body: '{ "ok": true }')

    stub_request(:post, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01\.jsp/)
      .with(body: { "court" => "TPH" })
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/single_court_info.html"))

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A02\.jsp/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/schedule_info.htm"))

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01_DOWNLOADCVS\.jsp/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/tph_dpt.csv"))

    stub_request(:get, /http:\/\/jirs\.judicial\.gov\.tw\/FJUD\/FJUDQRY01_1\.aspx/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/courts_info.html"))

    stub_request(:get, /http:\/\/jirs\.judicial\.gov\.tw\/FJUD\/FJUDQRY01_1\.aspx/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_index.html"))

    stub_request(:get, /http:\/\/jirs\.judicial\.gov\.tw\/FJUD\/FJUDQRY02_1\.aspx/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict_result.html"))

    stub_request(:get, /http:\/\/jirs\.judicial\.gov\.tw\/FJUD\/FJUDQRY03_1\.aspx/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/scrap_data/judgment.html"))
  end
end
