module Webmock
  def webmock_all!
    stub_request(:get, 'https://google.com/api.json')
      .to_return(headers: { 'Content-Type' => 'application/json' }, body: '{ "ok": true }')

    stub_request(:post, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01\.jsp/)
      .with(body: { 'court' => 'TPH' })
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

    stub_request(:get, /http:\/\/gist\.githubusercontent\.com\/raw\/lawyer.csv/)
      .to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/lawyers.csv"))

    stub_request(:post, /https:\/\/\S+:\S+@api\.twilio\.com\/\S+\/Accounts\/\S+\/Messages.json/)
      .to_return(status: 200, body: '{"sid": "SM5b846be440aa4f0cbda591a7c81e0b62", "date_created": "Thu, 25 Aug 2016 04:46:07 +0000", "date_updated": "Thu, 25 Aug 2016 04:46:07 +0000", "date_sent": null, "account_sid": "AC4d17f69a678c9ffaf4b190e92a340896", "to": "+886963063230", "from": "+18443293046", "messaging_service_sid": null, "body": "[development] \u7576\u4e8b\u4eba\u624b\u6a5f\u9a57\u8b49\u7c21\u8a0a \u767c\u9001\u81f3 0963063230: \u8a8d\u8b49\u78bc : 6073, http://localhost/party/phone/verify", "status": "queued", "num_segments": "2", "num_media": "0", "direction": "outbound-api", "api_version": "2010-04-01", "price": null, "price_unit": "USD", "error_code": null, "error_message": null, "uri": "/2010-04-01/Accounts/AC4d17f69a678c9ffaf4b190e92a340896/Messages/SM5b846be440aa4f0cbda591a7c81e0b62.json", "subresource_uris": {"media": "/2010-04-01/Accounts/AC4d17f69a678c9ffaf4b190e92a340896/Messages/SM5b846be440aa4f0cbda591a7c81e0b62/Media.json"}}')
  end
end
