module Webmock
  def webmock_all!
    stub_request(:get, "https://google.com/api.json").
      to_return(:headers => { 'Content-Type' => 'application/json' }, :body => '{ "ok": true }')
  end
end