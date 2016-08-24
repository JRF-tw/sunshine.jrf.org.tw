module Capybara
  module CommonHelper
    def manual_http_request(method, path)
      page.execute_script("$.ajax({url: '#{path}', data: {}, type: '#{method}'});")
      # Wait for the request to finish executing...
      Timeout.timeout(10) { loop until page.evaluate_script("jQuery.active").zero? }
    end
  end
end
